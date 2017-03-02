From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 09:25:38 +0100
Subject: [PATCH v2 1/5] pinctrl: sunxi: refactor pinctrl choice selecting
 for ARM64
In-Reply-To: <20170301180111.12365-2-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-2-icenowy@aosc.xyz>
Message-ID: <20170302082538.dej6h3l5zfdgttj4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 02:01:07AM +0800, Icenowy Zheng wrote:
> ARM64 Allwinner SoCs used to have every pinctrl driver selected in
> ARCH_SUNXI. Change this to make their default value to (ARM64 &&
> ARCH_SUNXI).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/58769f37/attachment.sig>
