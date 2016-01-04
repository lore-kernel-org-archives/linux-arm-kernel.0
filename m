From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Jan 2016 12:26:48 +0100
Subject: [RFC PATCH 5/5] arm64: Introduce Allwinner SoC config option
In-Reply-To: <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
References: <1450787267-26836-1-git-send-email-andre.przywara@arm.com>
 <1450787267-26836-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20160104112648.GD11722@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre, Arnd,

On Tue, Dec 22, 2015 at 12:27:47PM +0000, Andre Przywara wrote:
> To prepare for supporting the Allwinner A64 SoC, introduce a config
> option to allow compiling Allwinner (aka. sunxi) specific drivers
> for ARM64.
> This patch just defines the ARCH_SUNXI symbol to allow Allwinner
> specific drivers to be selected during kernel configuration.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

I'm ok taking this patch.

I'm not quite sure how the process works though with arm64. Should I
send a PR with this patch to Catalin, or does it go through the usual
arm-soc maintainers?

We should also probably extend the MAINTAINERS entry, shouldn't we?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/3fa8d2eb/attachment.sig>
