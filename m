From: stevenrwalter@gmail.com (Steven Walter)
Date: Tue, 8 Dec 2009 17:17:47 -0500
Subject: cache aliasing in dup_mmap
In-Reply-To: <20091130092022.GA1638@n2100.arm.linux.org.uk>
References: <20090929191108.GA13568@n2100.arm.linux.org.uk>
	<20091105144830.GC21681@n2100.arm.linux.org.uk>
	<e06498070911130649k2051e4cfh2066cf0b9fdabbaf@mail.gmail.com>
	<20091116163028.GA3568@n2100.arm.linux.org.uk>
	<e06498070911160923i2273b6aai6f144b36289203d2@mail.gmail.com>
	<20091116222016.GF3568@n2100.arm.linux.org.uk>
	<20091119085735.GA14178@n2100.arm.linux.org.uk>
	<e06498070911191008t1861e730u5cdb49187af00ae0@mail.gmail.com>
	<20091123203110.GH18142@n2100.arm.linux.org.uk>
	<20091130092022.GA1638@n2100.arm.linux.org.uk>
Message-ID: <e06498070912081417i614a0308x80f516145ee28472@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2009 at 4:20 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 23, 2009 at 08:31:10PM +0000, Russell King - ARM Linux wrote:
>> I'd just like to keep this issue hot so it doesn't get forgotten about.
>> Are we at a conclusive point on this?
>
> Today is decision day. ?Do we go with these two patches or not?

Okay, results are in, albeit later than advertised.  We had ~2600 runs
on the patched kernel and it appears that the cache issue is fixed.
-- 
-Steven Walter <stevenrwalter@gmail.com>
