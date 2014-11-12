From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 12 Nov 2014 17:59:25 +0100
Subject: [PATCH 2/3] power: reset: imx-snvs-poweroff: add power off
 driver for i.mx6
In-Reply-To: <1415780439-29728-3-git-send-email-b38343@freescale.com>
References: <1415780439-29728-1-git-send-email-b38343@freescale.com>
 <1415780439-29728-3-git-send-email-b38343@freescale.com>
Message-ID: <20141112165925.GA27681@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 12, 2014 at 04:20:38PM +0800, Robin Gong wrote:
> This driver register pm_power_off with snvs power off function. If
> your boards NOT use PMIC_ON_REQ to turn on/off external pmic, or use
> other pin to do, please disable the driver in dts, otherwise, your
> pm_power_off maybe overwrote by this driver.
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/6ae6d3e0/attachment.sig>
