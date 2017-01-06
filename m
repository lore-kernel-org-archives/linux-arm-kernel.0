From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 6 Jan 2017 14:57:15 +0100
Subject: [PATCH 2/4] musb: sunxi: add support for the variant in H3/V3s SoC
In-Reply-To: <20170103152534.20118-3-icenowy@aosc.xyz>
References: <20170103152534.20118-1-icenowy@aosc.xyz>
 <20170103152534.20118-3-icenowy@aosc.xyz>
Message-ID: <20170106135715.y7cwrwqyzybl6t5m@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 11:25:32PM +0800, Icenowy Zheng wrote:
> Allwinner H3/V3s features a variant of MUSB controller, which lacks one
> endpoint.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/7fd31da1/attachment.sig>
