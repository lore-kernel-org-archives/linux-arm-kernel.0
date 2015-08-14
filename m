From: eric@anholt.net (Eric Anholt)
Date: Fri, 14 Aug 2015 11:29:02 -0700
Subject: [GIT PULL] RPi DT changes due for v4.3
In-Reply-To: <20150813103056.GY30160@localhost>
References: <20150811160642.GQ18282@x1> <20150813103056.GY30160@localhost>
Message-ID: <878u9dhggh.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson <olof@lixom.net> writes:

> Hi,
>
> On Tue, Aug 11, 2015 at 05:06:42PM +0100, Lee Jones wrote:
>> ARM SoC Chaps,
>> 
>> Please find a couple of simple RPi changes pertaining to Firmware.
>> 
>> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
>> 
>>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-dt-for-armsoc-4.3
>> 
>> for you to fetch changes up to fd26f8830979de48eb3f1c253eb9d2ee2e468eb6:
>> 
>>   dt/bindings: Add binding for the Raspberry Pi firmware driver (2015-08-11 16:56:41 +0100)
>
> I've merged this but I'm a little confused about bcm2835 maintainership:
> I got a MAINTAINERS update from Florian earlier grouped in a set of
> other bcm changes (adding Eric), and now this directly from you.
>
> In general the bcm platforms are quite diverse and we've asked Florian
> to be the funnel for all of the new ones, but I don't think we talked
> much about 2835 at that time. Should we expect to see merges directly
> from you and the other maintainers there or will it go through Florian?

I'd been talking with Arnd and Florian about the delays in RPi patch
acceptance (Stephen and Lee have limited time to dedicate to 2835), and
Florian suggested me becoming a maintainer and routing patches through
him.  He's been great to work with and has had useful feedback on my
patches.

I was kind of surprised to see Lee send this pull request -- these
patches had been sitting un-merged for 2 months and pings on irc didn't
get replies, so I thought I was stepping in where the others definitely
didn't have time.  It was also odd to see just these two patches, but
not the actual driver.

I'm willing to do the merging process for 2835, and if I'm doing so, I
like the idea of feeding it through a more experienced maintainer who's
ready to look at my pull requests whenever, without bothering the main
arm-soc folks.  My goal here, besides my actual job of getting open
source graphics working for Broadcom, is to hopefully push the rpi
foundation toward getting their code merged, so that this hardware fully
works on stock upstream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150814/a6508819/attachment.sig>
