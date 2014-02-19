From: mporter@linaro.org (Matt Porter)
Date: Wed, 19 Feb 2014 10:00:44 -0500
Subject: [PATCH v8 0/4] ARM: BCM5301X: initial support for the
 BCM5301X/BCM470X SoCs with ARM CPU
In-Reply-To: <1391468506-5800-1-git-send-email-hauke@hauke-m.de>
References: <1391468506-5800-1-git-send-email-hauke@hauke-m.de>
Message-ID: <20140219150044.GG29906@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 12:01:42AM +0100, Hauke Mehrtens wrote:
> This adds initial support for Broadcom network SoC from the BCM5301X 
> and BCM470X line.
> 
> I do not have any documentation, only the vendor source code published 
> by Asus and Netgear to conform with the GPL, it would be nice to get 
> some documentation for this Soc like this
> https://www.broadcom.com/collateral/pg/440X-PG02-R.pdf
> for the Broadcom BCM440X Ethernet controller.
> 
> With some additional patches I got Ethernet working with ~250 MBit/s.
> 
> A bootlog can be found here:
> http://hauke-m.de/files/openwrt/devices/R6250/openwrt-boot-2014-01-05.txt
> 
> This is based on 3.14-rc1.
> 
> Christian Daudt could you please take these patches.

Applied for 3.15

Note: our tree is now git://git.github.com/broadcom/mach-bcm

-Matt
