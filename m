From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 22 Jul 2014 15:30:53 -0700
Subject: [PATCH v8 00/11] ARM: brcmstb: Add Broadcom STB SoC support
In-Reply-To: <6456081.JRV4vu9CHq@wuerfel>
References: <1405976886-27807-1-git-send-email-computersforpeace@gmail.com>
 <5044348.IEPQPrahyu@wuerfel> <20140722213350.GX2593@beef>
 <6456081.JRV4vu9CHq@wuerfel>
Message-ID: <20140722223053.GH28323@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 12:24:23AM +0200, Arnd Bergmann wrote:
> On Tuesday 22 July 2014 17:33:50 Matt Porter wrote:
> > > > For the reset of mach-bcm stuff, I'll just send an arm-soc pull request
> > > > soon enough, unless Matt/Arnd/Olof object.
> > > 
> > > I'll wait for Matt to comment before pulling it, otherwise that sounds
> > > fine.
> > 
> > I'm fine with it, but we were asked to have one request for bcm5301x to
> > make life easy for the arm-soc team.

That's all news to me; thanks for the explanation.

> > If we want each platform to do pull
> > requests directly with arm-soc we should advise Hauke to do the same as
> > well with bcm5301x. I think the chances of Kconfig/Makefile conflicts are
> > relatively low as there's a dwindling amount of code of interest in new
> > platform mach directories like ours.
> > 
> > I would like to see a consistent path for all BCM platform maintainers.
> 
> Ok. Brian, please send the pull request or patches to Matt then.

Sure thing. I'll drop the 'select POWER_RESET_BRCMSTB' and also drop our
git tree from MAINTAINERS. I'll send v9 of the reboot driver separately,
targeted at Sebastian (or else to also defer to Matt's tree).

Thanks,
Brian
