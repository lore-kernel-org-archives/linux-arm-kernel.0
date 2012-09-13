From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 13 Sep 2012 17:48:34 +0200
Subject: [PATCH v4 00/10] pinctrl: mvebu: pinctrl driver
In-Reply-To: <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20120913174834.79727630@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Thu, 13 Sep 2012 17:41:42 +0200, Sebastian Hesselbarth wrote:

> This patch set adds a core pinctrl driver for Marvell MVEBU SoCs and
> SoC specific stubs for Armada 370, Armada XP, Dove, and Kirkwood.
> The SoC specific stubs use the pinctrl-mvebu core driver that handles
> pinctrl API and register accesses for common pinctrl registers.
> 
> As especially Dove has some pinctrl registers that do not match the
> common pinctrl register layout the core driver has been extended by
> some callbacks to allow uncommon Dove pinctrl registers.
> 
> DT binding documentation is added for all supported SoCs but as
> Dove and Kirkwood are not yet ready for full DT support, the pinctrl
> driver is only activated for Armada 370 and XP.
> 
> The driver of latest patch v4 has been tested on Dove, Armada 370, 
> Armada XP, and 88f6281 variant of Kirkwood.

I confirm the testing of this v4 of the patch set on Armada 370 and
Armada XP, so for the whole series:

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
