From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jun 2011 13:00:48 +0200
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <BANLkTinSuce1SQkjKva+DoUVRoJrQjU10Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for an excellent patch set Marc, take that as an Acked-by from me FWIW.

On Thu, Jun 16, 2011 at 9:06 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:

> Patches against next-20110615 + my earlier GIC-PPI series. Tested on
> VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.

This is making it hopeless for me to test on a plain -rc3 kernel,
do you have a public git branch I can just pull in to get all this?

I would like to test on U8500 and also rebase Colins TWD
CPUfreq patch on top of this so it can go in on top of the
consolidations.

Thanks,
Linus Walleij
