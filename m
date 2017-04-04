From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 4 Apr 2017 17:45:44 +0200
Subject: [PATCH v4 0/5] Add support for the R_CCU on Allwinner H3/A64 SoCs
In-Reply-To: <20170404095100.18649-1-icenowy@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
Message-ID: <20170404154544.ofecao56dpcvk3wc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 05:50:55PM +0800, Icenowy Zheng wrote:
> Allwinner SoCs after sun6i-a31 nearly all have a R_CCU in PRCM part.
> (V3s and R40 do not have it, as they have even no PRCM)
> 
> This patch adds support for the ones on H3/A64.
> 
> Some clock/reset values are reserved for easier extending the support to
> A31/A23, but for this I think some changes to the PRCM MFD should be made,
> see [1] (Although this is only a sketch).
> 
> The r_pio device node is also added for A64, as the driver is already
> merged, and its depends (r_ccu) is now met.

Applied all, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/bcf68c72/attachment-0001.sig>
