From: mporter@linaro.org (Matt Porter)
Date: Fri, 14 Feb 2014 16:51:31 -0500
Subject: [PATCH v8 0/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <52FE4A42.3090309@gmail.com>
References: <1391468506-5800-1-git-send-email-hauke@hauke-m.de>
 <52FE4A42.3090309@gmail.com>
Message-ID: <20140214215131.GD29906@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Dropped arm at kernel.org as I think it's only intended for pull requests]

On Fri, Feb 14, 2014 at 08:54:26AM -0800, Florian Fainelli wrote:
> Hi Christian,
> 
> Le 03/02/2014 15:01, Hauke Mehrtens a ?crit :
> >This adds initial support for Broadcom network SoC from the BCM5301X
> >and BCM470X line.
> >
> >I do not have any documentation, only the vendor source code published
> >by Asus and Netgear to conform with the GPL, it would be nice to get
> >some documentation for this Soc like this
> >https://www.broadcom.com/collateral/pg/440X-PG02-R.pdf
> >for the Broadcom BCM440X Ethernet controller.
> >
> >With some additional patches I got Ethernet working with ~250 MBit/s.
> >
> >A bootlog can be found here:
> >http://hauke-m.de/files/openwrt/devices/R6250/openwrt-boot-2014-01-05.txt
> >
> >This is based on 3.14-rc1.
> >
> >Christian Daudt could you please take these patches.
> 
> Christian, have you been able to get a look at those patches? How do
> you want to proceed for patches affecting bcm5301x in the future?
> Except for a few cases (Kconfig, Makefile), support for bcm5301x is
> orthogonal to the other bcm-mobile SoCs, should that be taken care
> of by the arm-soc maintainers directly?

Based on Olof's suggestion on IRC, we'll want to take these through
Christian's tree and just give the arm-soc team a single set of pulls
for all platforms sharing mach-bcm/

I'll be helping Christian with this starting for 3.15. However, I'd like
his ack to be sure he's happy with this series too.  We have Arnd's ack
and my comments among others that were addressed so I'm good with it.

-Matt
