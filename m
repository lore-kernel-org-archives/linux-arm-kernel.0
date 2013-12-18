From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Dec 2013 13:55:16 -0700
Subject: [PATCH V2 2/2] ARM: tegra: add ams AS3722 device to Venice2 DT
In-Reply-To: <1387371179-16725-2-git-send-email-ldewangan@nvidia.com>
References: <1387371179-16725-1-git-send-email-ldewangan@nvidia.com>
 <1387371179-16725-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <52B20BB4.50506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2013 05:52 AM, Laxman Dewangan wrote:
> Add ams AS3722 entry for gpio/pincontrol and regulators
> to venice2 DT.

This patch still causes:

> [    0.726545] as3722-pinctrl as3722-pinctrl: pin gpio0 already requested by as3722-pinctrl; cannot claim for as3722-regulator
> [    0.737681] as3722-pinctrl as3722-pinctrl: pin-0 (as3722-regulator) status -22
> [    0.744895] as3722-pinctrl as3722-pinctrl: could not request pin 0 (gpio0) from group gpio0  on device as3722-pinctrl
> [    0.755500] as3722-regulator as3722-regulator: Error applying setting, reverse things back
