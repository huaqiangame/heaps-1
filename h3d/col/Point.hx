package h3d.col;
using hxd.Math;

class Point {

	public var x : Float;
	public var y : Float;
	public var z : Float;

	public inline function new(x=0.,y=0.,z=0.) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public inline function scale( v : Float ) {
		x *= v;
		y *= v;
		z *= v;
	}

	public inline function inFrustum( f : Frustum, ?m : h3d.Matrix ) {
		return f.hasPoint(this);
	}

	public inline function set(x, y, z) {
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public inline function multiply( f : Float ) {
		return new Point(x * f, y * f, z * f);
	}

	public inline function sub( p : Point ) {
		return new Point(x - p.x, y - p.y, z - p.z);
	}

	public inline function add( p : Point ) {
		return new Point(x + p.x, y + p.y, z + p.z);
	}

	public inline function inc( p : Point ) {
		x += p.x;
		y += p.y;
		z += p.z;
	}

	public inline function cross( p : Point ) {
		return new Point(y * p.z - z * p.y, z * p.x - x * p.z,  x * p.y - y * p.x);
	}

	public inline function equals( other : Point ) : Bool {
		return x == other.x && y == other.y && z == other.z;
	}

	public inline function lengthSq() {
		return x * x + y * y + z * z;
	}

	public inline function setLength(len:Float) {
		normalizeFast();
		x *= len;
		y *= len;
		z *= len;
	}

	public inline function length() {
		return lengthSq().sqrt();
	}

	public inline function dot( p : Point ) {
		return x * p.x + y * p.y + z * p.z;
	}

	public inline function distanceSq( p : Point ) {
		var dx = p.x - x;
		var dy = p.y - y;
		var dz = p.z - z;
		return dx * dx + dy * dy + dz * dz;
	}

	public inline function distance( p : Point ) {
		return distanceSq(p).sqrt();
	}

	public function normalize() {
		var k = x * x + y * y + z * z;
		if( k < hxd.Math.EPSILON ) k = 0 else k = k.invSqrt();
		x *= k;
		y *= k;
		z *= k;
		return this;
	}

	public inline function normalizeFast() {
		var k = x * x + y * y + z * z;
		k = k.invSqrt();
		x *= k;
		y *= k;
		z *= k;
		return this;
	}

	public inline function lerp( p1 : Point, p2 : Point, k : Float ) {
		var x = Math.lerp(p1.x, p2.x, k);
		var y = Math.lerp(p1.y, p2.y, k);
		var z = Math.lerp(p1.z, p2.z, k);
		this.x = x;
		this.y = y;
		this.z = z;
	}

	public inline function transform( m : Matrix ) {
		var px = x * m._11 + y * m._21 + z * m._31 + m._41;
		var py = x * m._12 + y * m._22 + z * m._32 + m._42;
		var pz = x * m._13 + y * m._23 + z * m._33 + m._43;
		x = px;
		y = py;
		z = pz;
	}

	public inline function transform3x3( m : Matrix ) {
		var px = x * m._11 + y * m._21 + z * m._31;
		var py = x * m._12 + y * m._22 + z * m._32;
		var pz = x * m._13 + y * m._23 + z * m._33;
		x = px;
		y = py;
		z = pz;
	}

	public inline function toVector() {
		return new Vector(x, y, z);
	}

	public inline function clone() {
		return new Point(x,y,z);
	}

	public inline function load( p : Point ) {
		this.x = p.x;
		this.y = p.y;
		this.z = p.z;
	}

	public function toString() {
		return 'Point{${x.fmt()},${y.fmt()},${z.fmt()}}';
	}

	// No-allocation operations
	public function setSub(p0: Point, p1:Point) {
		this.x = p0.x - p1.x;
		this.y = p0.y - p1.y;
		this.z = p0.z - p1.z;
	}

	public function toArray(): Array<Float> {
		return [x,y,z];
	}
	// Return the 3x3 matrix of the output product of this and p (as a column major matrix)
	public function outer(p: Point): Matrix {
		var ret = new Matrix();
		ret._11 = p.x*x;
		ret._12 = p.x*y;
		ret._13 = p.x*z;

		ret._21 = p.y*x;
		ret._22 = p.y*y;
		ret._23 = p.y*z;

		ret._31 = p.z*x;
		ret._32 = p.z*y;
		ret._13 = p.z*z;

		return ret;
	}

}
