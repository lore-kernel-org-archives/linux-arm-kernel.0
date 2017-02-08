From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 8 Feb 2017 09:00:51 +0100
Subject: [PATCH v4 5/9] dt-bindings: remove transitional headers for
 Allwinner H3 CCU
In-Reply-To: <20170207183042.62699-6-icenowy@aosc.xyz>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
 <20170207183042.62699-6-icenowy@aosc.xyz>
Message-ID: <20170208080051.7atx3w2nosz43sib@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 02:30:38AM +0800, Icenowy Zheng wrote:
> As we have already changed the DTSI file, the trnasitional dt-bindings
> header sun8i-h3-ccu.h for clock and reset will not be needed any more.
> 
> Remove them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

This can be folded in the previous patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170208/e573cbee/attachment.sig>
