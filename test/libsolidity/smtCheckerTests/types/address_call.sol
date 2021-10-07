contract C
{
	uint x;
	mapping (uint => uint) map;
	function f(address a, bytes memory data) public {
		x = 0;
		map[0] = 0;
		mapping (uint => uint) storage localMap = map;
		(bool success, bytes memory ret) = a.call(data);
		assert(success);
		assert(x == 0);
		// Disabled because of Spacer nondeterminism.
		//assert(map[0] == 0);
		// Disabled because of Spacer nondeterminism.
		//assert(localMap[0] == 0);
	}
}
// ====
// EVMVersion: >spuriousDragon
// SMTEngine: all
// SMTIgnoreCex: yes
// SMTIgnoreInv: yes
// SMTIgnoreOS: macos
// ----
// Info 1180: Reentrancy property(ies) for :C:\n(!(<errorCode> >= 2) && (!(x <= 0) || (x' <= 0)))\n
