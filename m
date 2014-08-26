From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 26 Aug 2014 12:47:22 +0300
Subject: [PATCH] ARM: dts: omap54xx-clocks: Fix the l3 and l4 clock rates
In-Reply-To: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
References: <1409043098-12510-1-git-send-email-t-kristo@ti.com>
Message-ID: <53FC57AA.5040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/08/14 11:51, Tero Kristo wrote:
> Similarly to DRA7, OMAP5 has l3 and l4 clock rates incorrectly calculated.
> Fixed by using proper divider clock types for the clock nodes.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/boot/dts/omap54xx-clocks.dtsi |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/a0294f6b/attachment.sig>
