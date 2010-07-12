From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Jul 2010 13:50:47 -0600
Subject: ARM defconfig files
In-Reply-To: <AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
	<AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
Message-ID: <AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 1:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> I think Uwe could provide his script and add it to the kernel tree.
>> Then all architectures could benefit from it. ?Having the defconfig
>> files contain only those options which are different from the defaults
>> is certainly more readable, even on x86.
>
> Quite possible. But maintainers would need to be on the lookout of
> people actually using the script, and refusing to apply patches that
> re-introduce the whole big thing.

I can (partially) speak for powerpc.  If ARM uses this approach, then
I think we can do the same.  After the defconfigs are trimmed, I
certainly won't pick up any more full defconfigs.

Of course, I'm also operating under the assumption that this is a
temporary measure until one of the better solutions is implemented.  I
do suspect that the trimmed defconfigs will tend to be unstable and
will still require manual maintenance.  I think the Kconfig fragments
approach is the most promising if the dependencies issue can be
solved.

g.
