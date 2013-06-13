From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 14 Jun 2013 00:27:33 +0200
Subject: [PATCH 00/15] Final Samsung PWM support cleanup
In-Reply-To: <201306132217.44265.heiko@sntech.de>
References: <1370467100-10820-1-git-send-email-tomasz.figa@gmail.com>
 <1808375.nuQYa2FdfG@flatron> <201306132217.44265.heiko@sntech.de>
Message-ID: <201306140027.34181.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 13. Juni 2013, 22:17:43 schrieb Heiko St?bner:
> Am Donnerstag, 13. Juni 2013, 11:07:38 schrieb Tomasz Figa:
> > Hi Heiko, Sylwester,
> > 
> > On Thursday 13 of June 2013 01:52:05 Sylwester Nawrocki wrote:
> > > On 06/13/2013 01:38 AM, Heiko St?bner wrote:
> > > > Am Donnerstag, 13. Juni 2013, 01:13:47 schrieb Tomasz Figa:
> > > >> Hi Olof,
> > > >> 
> > > >> On Wednesday 12 of June 2013 16:00:23 Olof Johansson wrote:
> > > >>> On Wed, Jun 12, 2013 at 11:48:56PM +0200, Tomasz Figa wrote:
> > > >>>>> Needs testing on other platforms as I could only compile test for
> > > >>>>> them.
> > > >>> 
> > > >>> How/who can help here? WHo has and still cares for other affected
> > > >>> platforms?
> > > >>> 
> > > >>>>> 66 files changed, 627 insertions(+), 1580 deletions(-)
> > > >> 
> > > >> I will try to test this on Exynos 4 at work, if I somehow manage to
> > > >> find any way to use PWM on our boards (other than already-tested PWM
> > > >> clocksource).
> > > >> 
> > > >> Unfortunately, except S3C6410, I don't have access to other
> > > >> platforms, or at least I won't in any reasonable time.
> > > >> 
> > > >> If I remember correctly, in case of my watchdog support cleanup,
> > > >> Kukjin
> > > >> has been able to test it on S5P64x0.
> > > >> 
> > > >> Heiko and Sylwester used to have some s3c24xx-based boards, not sure
> > > >> if
> > > >> they still do and are interested in their support in mainline.
> > > >> 
> > > >> So all left is S5PC100 (for which I couldn't find anyone who cares)
> > > >> and
> > > >> Exynos5.
> > > >> 
> > > >>> Nice cleanup.
> > > >> 
> > > >> Thanks.
> > > >> 
> > > >>>> Any comments for this series?
> > > >>> 
> > > >>> Yes, above. :) In general looks good -- testing coverage is a bit
> > > >>> of a
> > > >>> concern.
> > > >> 
> > > >> Yeah. Unfortunately all I could do was testing on Tiny6410 and
> > > >> compile
> > > >> testing on others. I hope we find some really helpful people over
> > > >> here who could waste a bit of their precious time for this museum.
> > > >> ;)
> > > > 
> > > > I'll try to give it a testrun tomorrow. And my s3c2416 will always be
> > > > the first-love-architecture for me ;-)
> > > 
> > > I'll likely test it tomorrow on a Mini2440 board, I was going to do it
> > > earlier
> > > but got distracted by plenty other things that needed attention too. At
> > > least
> > > that's one of the reasons I got the board - testing the cross-platform
> > > cleanups
> > > and ensuring they are not breaking the older platforms.
> > 
> > Thank you both for your support. Looking forward for testing results :)
> 
> on a s3c2416-based machine for dt and non-dt case
> [with the limit that my machine does not has anything connected to the pwm
> outputs, so I only get to test the base-pwm and timer part]
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>

And of course forgot the other thing:

Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks for doing this, as with this series I can now also resurrect my s3c2416 
ccf patch :-)


Heiko
