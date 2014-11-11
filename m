From: smoch@web.de (Soeren Moch)
Date: Tue, 11 Nov 2014 22:42:52 +0100
Subject: [PATCH v4 2/3] power: reset: imx-snvs-poweroff: add power off
 driver for i.mx6
In-Reply-To: <1411703947-31956-3-git-send-email-b38343@freescale.com>
Message-ID: <546282DC.7070606@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This driver register pm_power_off with snvs power off function. If
> your boards NOT use PMIC_ON_REQ to turn on/off external pmic, or use
> other pin to do, please disable the driver in dts, otherwise, your
> pm_power_off maybe overwrote by this driver.

> Signed-off-by: Robin Gong <b38343@freescale.com>

Any news on this?
Maybe this patchset was lost because it was sent to the old email address of Shawn?

I tested this patchset on a TBS2910 board, works as expected.  Very important feature for me.


Tested-by: Soeren Moch <smoch@web.de>
