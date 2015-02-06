From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 6 Feb 2015 15:59:05 +0100
Subject: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
In-Reply-To: <1423233788.31516.5.camel@AMDC1943>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd> <1423233788.31516.5.camel@AMDC1943>
Message-ID: <20150206145904.GA7872@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2015-02-06 15:43:08, Krzysztof Kozlowski wrote:
> On pi?, 2015-02-06 at 14:49 +0100, Pavel Machek wrote:
> > On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> > > Use power_supply_put() to decrement the power supply's device reference
> > > counter.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > 
> > 11,13,20 nothing obviously wrong. But I'm not sure if I studied them
> > closely enough to warrant an ACK.
> > 
> > It would be good to get this into kernel -- I seen no bad comments,
> > and it is not going to improve without merge into mainline.
> 
> Thanks for looking at patchset. It would be really nice if this could be
> tested for some time in linux-next. Such testing would help a lot. But I
> need acks from various maintainers for that.

Actually, you don't. The various maintainers clearly don't care at
this point. They had enough time. So you select one maintainer you
want to push this through, and you push it.

Someone may complain, so you'll solve the feedback...

Good luck,
									Pavel

> Of course the patchset to big enough to go into 3.20. If needed this
> could be taken gradually in following steps:
> 1. Patches 1-2 (patch 2 touches *all drivers*),
> 2. Patches 3-10 (touch only individual drivers),
> 3. Patch 11 (again *everything* changed),
> 4. Patches 12-20 (individual changes).
> 
> In such case I will refresh everything after each step so new drivers
> would be also updated.
> 
> Thanks again Pavel for prompt replies.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
