From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Aug 2012 23:41:32 +0100
Subject: [PATCH 2/5] ASoC: Davinci: McASP: add device tree support for
 McASP
In-Reply-To: <1344948125-5649-3-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-3-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120817224131.GJ18871@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 06:12:02PM +0530, Hebbar, Gururaja wrote:

> +- op-mode : I2S/DIT ops mode.

This would normally be part of the machine binding since it needs to be
applied to both ends of the link.  When adding it could you come up with
a generic binding for this in terms of the current ASoC DAI paremeters
please?  That way we'll be able to have other machine drivers be
consistent with this one.

> +- tdm-slots : Slots for TDM operation.

This would normally also be a machine driver thing though it's less
normal to need to configure this on both ends.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/2771ff94/attachment.sig>
