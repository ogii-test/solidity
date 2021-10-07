abstract contract D {
	function d() external virtual;
}

contract C {
	uint x;
	D d;

	bool lock;
	modifier mutex {
		require(!lock);
		lock = true;
		_;
		lock = false;
	}

	function set(uint _x) mutex public {
		x = _x;
	}

	function f() mutex public {
		uint y = x;
		d.d();
		assert(y == x);
	}
}
// ====
// SMTEngine: all
// SMTIgnoreInv: yes
// ----
// Info 1180: Reentrancy property(ies) for :C:\n((((x' + ((- 1) * x)) = 0) || !lock) && (<errorCode> <= 0) && (lock' || !lock))\n
