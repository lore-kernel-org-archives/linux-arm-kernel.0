From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jun 2011 14:27:50 +0100
Subject: [RFC PATCH 00/16] Consolidation: move SMP local timers to
	driver/clocksource
In-Reply-To: <BANLkTinSuce1SQkjKva+DoUVRoJrQjU10Q@mail.gmail.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
	<BANLkTinSuce1SQkjKva+DoUVRoJrQjU10Q@mail.gmail.com>
Message-ID: <4DFB5656.2060000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 17/06/11 12:00, Linus Walleij wrote:
> Thanks for an excellent patch set Marc, take that as an Acked-by from me FWIW.
> 
> On Thu, Jun 16, 2011 at 9:06 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> Patches against next-20110615 + my earlier GIC-PPI series. Tested on
>> VExpress, PB11MP, Pandaboard, Tegra Harmony and Exynos4 SMDK-v310.
> 
> This is making it hopeless for me to test on a plain -rc3 kernel,
> do you have a public git branch I can just pull in to get all this?
> 
> I would like to test on U8500 and also rebase Colins TWD
> CPUfreq patch on top of this so it can go in on top of the
> consolidations.

I've created a new repository on git.kernel.org:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
and rebased my stuff on top of -rc3 in the "local_timer_devices" branch.
Tested on a PB11MP.

It may take some time for the mirrors to catch up...

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
