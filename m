From: eric@anholt.net (Eric Anholt)
Date: Fri, 04 Sep 2015 12:05:34 -0700
Subject: [GIT PULL] RPi DT changes due for v4.3
In-Reply-To: <20150827111046.GB4796@x1>
References: <20150811160642.GQ18282@x1> <20150813103056.GY30160@localhost>
 <878u9dhggh.fsf@eliezer.anholt.net> <20150827111046.GB4796@x1>
Message-ID: <87613q57k1.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee Jones <lee@kernel.org> writes:

> On Fri, 14 Aug 2015, Eric Anholt wrote:
>> Olof Johansson <olof@lixom.net> writes:
>> > On Tue, Aug 11, 2015 at 05:06:42PM +0100, Lee Jones wrote:
>> >> ARM SoC Chaps,
>> >> 
>> >> Please find a couple of simple RPi changes pertaining to Firmware.
>> >> 
>> >> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
>> >> 
>> >>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
>> >> 
>> >> are available in the git repository at:
>> >> 
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-dt-for-armsoc-4.3
>> >> 
>> >> for you to fetch changes up to fd26f8830979de48eb3f1c253eb9d2ee2e468eb6:
>> >> 
>> >>   dt/bindings: Add binding for the Raspberry Pi firmware driver (2015-08-11 16:56:41 +0100)
>> >
>> > I've merged this but I'm a little confused about bcm2835 maintainership:
>> > I got a MAINTAINERS update from Florian earlier grouped in a set of
>> > other bcm changes (adding Eric), and now this directly from you.
>> >
>> > In general the bcm platforms are quite diverse and we've asked Florian
>> > to be the funnel for all of the new ones, but I don't think we talked
>> > much about 2835 at that time. Should we expect to see merges directly
>> > from you and the other maintainers there or will it go through Florian?
>> 
>> I'd been talking with Arnd and Florian about the delays in RPi patch
>> acceptance (Stephen and Lee have limited time to dedicate to 2835), and
>> Florian suggested me becoming a maintainer and routing patches through
>> him.  He's been great to work with and has had useful feedback on my
>> patches.
>> 
>> I was kind of surprised to see Lee send this pull request -- these
>> patches had been sitting un-merged for 2 months and pings on irc didn't
>> get replies, so I thought I was stepping in where the others definitely
>> didn't have time.  It was also odd to see just these two patches, but
>> not the actual driver.
>> 
>> I'm willing to do the merging process for 2835, and if I'm doing so, I
>> like the idea of feeding it through a more experienced maintainer who's
>> ready to look at my pull requests whenever, without bothering the main
>> arm-soc folks.  My goal here, besides my actual job of getting open
>> source graphics working for Broadcom, is to hopefully push the rpi
>> foundation toward getting their code merged, so that this hardware fully
>> works on stock upstream.
>
> Apologies for the confusion caused by this pull-request.  After
> speaking with Florian last cycle the plan was to send the request to
> him prior to him sending to ARM-SoC; however, I didn't realise how
> early in the cycle he was going to send that request and I missed the
> boat.  So rather than miss the cycle, I decided just to send directly
> to ARM-SoC instead.
>
> I do resent the IRQ comment though, as I'm always on IRC during
> working hours and (unless something has gone wrong) I have a proxy
> which collects missed messages and replays them back to me, so in
> theory I shouldn't miss a message.  All messages you've sent to me
> I've replied to.
>
> The Firmware patches wouldn't have ever been part of this set without
> explicit request/permission from the Maintainer.  So that's why the
> driver patches weren't part of this set.

For what it's worth, the recent IRC message I was referring to was:

Jun 30 14:02:09 <anholt> lag: the rpi tree doesn't have the rpi firmware
patches you said you applied -- are they somewhere else?

and Stephen Warren had back on June 5th replied to your question about
who the maintainer was with the analysis (same as I'd done by reading
MAINTAINERS and the logs).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150904/a49613fe/attachment.sig>
