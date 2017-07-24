From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Jul 2017 09:57:46 +0200
Subject: [PATCH v2 0/2] AXP803 regulators support for Pine64 and SoPine
In-Reply-To: <20170722021843.6768-1-icenowy@aosc.io>
References: <20170722021843.6768-1-icenowy@aosc.io>
Message-ID: <20170724075746.cuv7wclwzj5mhpm7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 22, 2017 at 10:18:41AM +0800, Icenowy Zheng wrote:
> The Pine64 and SoPine w/ baseboard boards have an AXP803 PMIC, and the
> regulators of the PMIC are used.
> 
> This patchset adds the regulators to the device tree of these two boards.
> 
> The first patch is for Pine64 and the second if for SoPine w/ official
> baseboard.

Applied the two.

> The patches that drop the dummy regulators in v1 are removed.

Please resend that one.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170724/6912e353/attachment.sig>
