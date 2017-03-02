From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 2 Mar 2017 09:26:07 +0100
Subject: [PATCH v2 3/5] dt-bindings: fix for Allwinner H5 pinctrl's
 compatible
In-Reply-To: <20170301180111.12365-4-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-4-icenowy@aosc.xyz>
Message-ID: <20170302082607.gztuixghoyk5wabv@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 02:01:09AM +0800, Icenowy Zheng wrote:
> The compatible for Allwinner H5 pin controller is wrong written as
> allwinner,sun50i-h5-r-pinctrl, however, it's really a generic pinctrl
> rather than a "r" one.
> 
> Fix this compatible string.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170302/20436b4a/attachment.sig>
