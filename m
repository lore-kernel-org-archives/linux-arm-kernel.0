From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 10:05:49 +0100
Subject: [PATCH v2 1/4] arm: sunxi: add support for V3s SoC
In-Reply-To: <20170116180116.36729-2-icenowy@aosc.xyz>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
Message-ID: <20170117090549.uqwsiwmclzhx7456@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 02:01:13AM +0800, Icenowy Zheng wrote:
> Allwinner V3s is a low-end single-core Cortex-A7 SoC, with 64MB
> integrated DRAM, and several peripherals.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes in v2:
> - Used linux-sunxi.org wiki hosted address of V3s datasheet.
> 
> Note: the V3s datasheet contains its user manual.

That would be great to use User Manual in the filename rather than
datasheet then. The datasheet is something different.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/cc6f0851/attachment-0001.sig>
