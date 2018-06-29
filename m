From: trini@konsulko.com (Tom Rini)
Date: Fri, 29 Jun 2018 16:53:26 -0400
Subject: [U-Boot, 4/4] ARM: mach-omap2: omap3/am335x: Enable ACR::IBE on
 Cortex-A8 SoCs for CVE-2017-5715
In-Reply-To: <20180612202411.29798-5-nm@ti.com>
References: <20180612202411.29798-5-nm@ti.com>
Message-ID: <20180629205326.GL18596@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 03:24:11PM -0500, Nishanth Menon wrote:

> Enable CVE-2017-5715 option to set the IBE bit. This enables kernel
> workarounds necessary for the said CVE.
> 
> With this enabled, Linux reports:
> CPU0: Spectre v2: using BPIALL workaround
> 
> This workaround may need to be re-applied in OS environment around low
> power transition resume states where context of ACR would be lost (off-mode
> etc).
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/9b9c813c/attachment.sig>
