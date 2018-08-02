From: broonie@kernel.org (Mark Brown)
Date: Thu, 2 Aug 2018 11:44:43 +0100
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180802103425.3053-4-o.rempel@pengutronix.de>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
Message-ID: <20180802104443.GH9117@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 12:34:22PM +0200, Oleksij Rempel wrote:
> Export pm_power_off_prepare. It is needed to implement power off on
> Freescale/NXP iMX6 based boards with external power management
> integrated circuit (PMIC).

I thought we'd got an ack for this from Raphael on a previous version or
am I mistaken?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/f5b524d4/attachment.sig>
