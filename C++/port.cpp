#include <iostream>
#include <vector>
#include <memory>
#include <thread>
#include <chrono>
#include <ctime>
#include <map>

using namespace std;

// ---------------- Abstract base class ----------------
class WaterVehicle {
protected:
    string name;
    int year;
public:
    WaterVehicle(string n, int y) : name(n), year(y) {}
    virtual void print_info() = 0;
    virtual void load() = 0;
    virtual void unload() = 0;
    virtual string type() = 0;
    virtual ~WaterVehicle() = default;
    string get_name() const { return name; }
};

// ---------------- Derived classes ----------------
class Ship : public WaterVehicle {
    int cargo_capacity;
public:
    Ship(string n, int y, int cap) : WaterVehicle(n, y), cargo_capacity(cap) {}
    void print_info() override {
        cout << "[Ship] " << name << " (" << year << "), Capacity: " << cargo_capacity << " tons\n";
    }
    void load() override { cout << ">> Loading containers on ship " << name << "...\n"; }
    void unload() override { cout << ">> Unloading cargo from ship " << name << "...\n"; }
    string type() override { return "Ship"; }
};

class Submarine : public WaterVehicle {
    int max_depth;
public:
    Submarine(string n, int y, int depth) : WaterVehicle(n, y), max_depth(depth) {}
    void print_info() override {
        cout << "[Submarine] " << name << " (" << year << "), Max depth: " << max_depth << "m\n";
    }
    void load() override { cout << ">> Loading torpedoes on submarine " << name << "...\n"; }
    void unload() override { cout << ">> Unloading supplies from submarine " << name << "...\n"; }
    void emergency_departure() {
        cout << "!! Emergency dive for " << name << "! Leaving port immediately.\n";
    }
    string type() override { return "Submarine"; }
};

class Sailboat : public WaterVehicle {
    int sail_area;
public:
    Sailboat(string n, int y, int area) : WaterVehicle(n, y), sail_area(area) {}
    void print_info() override {
        cout << "[Sailboat] " << name << " (" << year << "), Sail area: " << sail_area << " m²\n";
    }
    void load() override { cout << ">> Loading personal gear on sailboat " << name << "...\n"; }
    void unload() override { cout << ">> Unloading luggage from sailboat " << name << "...\n"; }
    string type() override { return "Sailboat"; }
};

// ---------------- Logger and timer ----------------
class Port {
    bool busy = false;
    vector<string> logs;
    map<string, int> visit_duration; // vehicle name -> seconds
    vector<shared_ptr<WaterVehicle>> history;

public:
    void log_event(const string& msg) {
        time_t now = time(nullptr);
        logs.push_back("[" + string(ctime(&now)) + "] " + msg);
    }

    void accept(shared_ptr<WaterVehicle> v) {
        if (busy) {
            cout << ">> Port is currently busy!\n";
            return;
        }
        busy = true;
        cout << "\n>>> Accepting vehicle into port...\n";
        v->print_info();
        v->load();
        log_event("Accepted " + v->type() + ": " + v->get_name());
        history.push_back(v);
        visit_duration[v->get_name()] = simulate_docking();
        busy = false;
    }

    void release(shared_ptr<WaterVehicle> v) {
        if (busy) {
            cout << ">> Port is currently busy!\n";
            return;
        }
        busy = true;
        cout << "\n<<< Releasing vehicle from port...\n";
        v->unload();
        log_event("Released " + v->type() + ": " + v->get_name());
        busy = false;
    }

    int simulate_docking() {
        int seconds = rand() % 5 + 2;
        this_thread::sleep_for(chrono::seconds(seconds));
        return seconds;
    }

    void show_log() {
        cout << "\n--- Port Event Log ---\n";
        for (const auto& entry : logs) {
            cout << entry;
        }
    }

    void show_stats() {
        cout << "\n--- Visit Duration Summary ---\n";
        for (const auto& [name, sec] : visit_duration) {
            cout << name << " stayed for ~" << sec << " seconds.\n";
        }
    }

    void show_visited() {
        cout << "\n--- All Vessels That Visited ---\n";
        for (const auto& v : history) {
            cout << "- " << v->type() << ": " << v->get_name() << "\n";
        }
    }
};

// ---------------- Main ----------------
int main() {
    srand(time(nullptr));

    auto ship = make_shared<Ship>("Poseidon", 2018, 3000);
    auto sub = make_shared<Submarine>("Kraken", 2015, 900);
    auto sailboat = make_shared<Sailboat>("Zephyr", 2021, 100);

    Port port;

    port.accept(ship);
    port.release(ship);

    port.accept(sub);
    dynamic_pointer_cast<Submarine>(sub)->emergency_departure(); // Bonus method
    port.release(sub);

    port.accept(sailboat);
    port.release(sailboat);

    port.show_log();
    port.show_stats();
    port.show_visited();

    return 0;
}
