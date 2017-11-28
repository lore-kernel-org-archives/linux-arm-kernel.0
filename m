From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 13:13:45 +0100
Subject: [PATCH] pinctrl: sunxi: add support for Allwinner H6 main pin
 controller
In-Reply-To: <20171128110614.9303-1-icenowy@aosc.io>
References: <20171128110614.9303-1-icenowy@aosc.io>
Message-ID: <20171128121345.xc3pbsx4hoaoapu4@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 28, 2017 at 07:06:14PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has two pin controllers like other Allwinner SoCs with
> ARISC: one main pin controller (called CPUX-PORT in user manual) and one
> pin controller in the CPUs power domain (called CPUS-PORT in user
> manual).
> 
> This commit adds support for the main pin controller in the H6 SoC.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This looks mostly fine, but we've had issues in the past with pinctrl
drivers submitted without SoC support, and we'll have to support them
forever.

Please resend this as part your upcoming serie to enable the H6.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/ce6da7a6/attachment.sig>
