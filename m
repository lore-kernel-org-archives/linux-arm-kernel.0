From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 13 Jul 2010 09:07:41 +0200
Subject: ARM defconfig files
In-Reply-To: <AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
References: <20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712185029.GB14425@pengutronix.de>
	<AANLkTinOuU-VVXaMwMp69CBp2Y4wxpoWybEQ34H5j0lJ@mail.gmail.com>
	<alpine.LFD.2.00.1007121510260.10598@xanadu.home>
	<AANLkTim-O00n9YPv7w4VCKjN-ETLijyTHomWUn4mZtTV@mail.gmail.com>
	<AANLkTilDoGbCx_0oKKPOeGG7TKL2VSNVII5ydmnQ77B7@mail.gmail.com>
Message-ID: <20100713070741.GB26442@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Jul 12, 2010 at 01:50:47PM -0600, Grant Likely wrote:
> On Mon, Jul 12, 2010 at 1:34 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Mon, Jul 12, 2010 at 12:17 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> I think Uwe could provide his script and add it to the kernel tree.
> >> Then all architectures could benefit from it. ?Having the defconfig
> >> files contain only those options which are different from the defaults
> >> is certainly more readable, even on x86.
> >
> > Quite possible. But maintainers would need to be on the lookout of
> > people actually using the script, and refusing to apply patches that
> > re-introduce the whole big thing.
> 
> I can (partially) speak for powerpc.  If ARM uses this approach, then
> I think we can do the same.  After the defconfigs are trimmed, I
> certainly won't pick up any more full defconfigs.
I just restarted my script on the powerpc defconfigs basing on rc5, I
assume they complete in a few days time.
 
> Of course, I'm also operating under the assumption that this is a
> temporary measure until one of the better solutions is implemented.
ack

>                                                                      I
> do suspect that the trimmed defconfigs will tend to be unstable and
> will still require manual maintenance.  I think the Kconfig fragments
> approach is the most promising if the dependencies issue can be
> solved.
I don't understand what you mean with unstable here.  They are sensible
to changed defaults in the Kconfig files which you can consider to be
good or bad.

And ack, I like the Kconfig approach, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
