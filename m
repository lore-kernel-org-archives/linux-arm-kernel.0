From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2012 05:22:35 +0000
Subject: [PATCH v2 03/11] ARM: EXYNOS: add clock part for EXYNOS5250 SoC
In-Reply-To: <052801ccec5d$137aa460$3a6fed20$%kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
 <20120213205444.GH11077@ponder.secretlab.ca>
 <052801ccec5d$137aa460$3a6fed20$%kim@samsung.com>
Message-ID: <201202160522.35249.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 February 2012, Kukjin Kim wrote:
> Thanks for your sharing.
> 
> OK, I and my team will follow up 'common struct clk' for exynos5250
> and it will be done maybe next week. And since I need to
> implement other features for exynos5250 now, firstly let me use this
> and test this series in linux-next in a day.

Ok, sounds good to me.

If you like, you could also send the patches that you expect to stay
stable for inclusion into arm-soc, or send the entire series as a
preliminary branch that I will put into arm-soc now and then
replace when you are done with the remaining changes.

As we discussed last week at Linaro Connect, we will start taking
both stable and unstable branches into arm-soc now, whereas we used
to take only stable branches. Anything that is not considered stable
yet will be marked as a staging branch, e.g. staging/samsung/soc instead
of samsung/soc.

> Ah, one more, would be better to us if arm-soc tree could provide
> the topic branch for 'common struct clk' working as a base.

Good point. Mike, can you send a pull request for whatever you have
now as another staging branch for arm-soc?

	Arnd
