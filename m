From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Mon, 14 May 2012 10:52:46 +0200
Subject: [PATCH 0/2] ARM: S3C64xx: cpuidle cleanups
In-Reply-To: <4FB048E4.8070405@linaro.org>
References: <1336572489-21457-1-git-send-email-daniel.lezcano@linaro.org>
 <4FB048E4.8070405@linaro.org>
Message-ID: <201205141052.47567.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 14. Mai 2012, 01:51:00 schrieb Daniel Lezcano:
> On 05/09/2012 04:08 PM, Daniel Lezcano wrote:
> > These couple of patches use the new cpuidle core api to refactor
> > some part of the code. The first one declares the states directly
> > in the driver declaration and the second one use the timekeeping
> > flag to let the cpuidle core to compute the idle time.
> > 
> > I don't have this board, I was not able to test these patches.
> > 
> > Daniel Lezcano (2):
> >    ARM: s3c64xx: cpuidle - declare the states with the new api
> >    ARM: s3c64xx: cpuidle - use timekeeping wrapper
> 
> Are these patches ok for inclusion ?

you might want to include the maintainer

	Kukjin Kim <kgene.kim@samsung.com>

and the samsung list

	linux-samsung-soc at vger.kernel.org

into your recipients


Heiko
