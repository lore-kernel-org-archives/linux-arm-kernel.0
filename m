From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 17:06:53 +0200
Subject: [PATCH 1/7] clk: sunxi-ng: add support for H6 PRCM CCU
In-Reply-To: <20180503183847.11046-2-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-2-icenowy@aosc.io>
Message-ID: <20180504150653.n2rqqhr45hrpjfw6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:41AM +0800, Icenowy Zheng wrote:
> The H6 has clock/reset controls in PRCM part, like old SoCs such as H3
> and A64. However, the PRCM CCU is rearranged; the register arragement
> is now similar to the main CCU of H6, and the PRCM now has two APB
> buses to control -- one is clocked from AHB clock derivde from AR100
> clock, the other is clocked from the same mux with AR100 clock.
> Therefore a new driver is written for it.
> 
> As there's no official document about the PRCM in H6, all the information
> are indirectly collected from BSP and parts of the document, and the
> information source is noted as comments in the driver's source code. If
> reliable information is provided furtherly, the driver needs to be
> rechecked.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/36132935/attachment.sig>
