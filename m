From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 4 May 2018 17:10:00 +0200
Subject: [PATCH 5/7] arm64: allwinner: h6: add R_INTC interrupt controller
In-Reply-To: <20180503183847.11046-6-icenowy@aosc.io>
References: <20180503183847.11046-1-icenowy@aosc.io>
 <20180503183847.11046-6-icenowy@aosc.io>
Message-ID: <20180504151000.uuvd54nzxe6p7b2f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2018 at 02:38:45AM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has also a R_INTC interrupt controller like Allwinner
> A64 SoC, but has its base address changed due to the memory map change
> in H6.
> 
> Add it into the device tree.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/9fc17ff6/attachment.sig>
