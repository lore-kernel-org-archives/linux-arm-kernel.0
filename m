From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Sep 2015 08:57:42 +0200
Subject: [PATCH v4 1/5] soc: sunxi: Add Allwinner Reduced Serial Bus
 (RSB) controller bindings
In-Reply-To: <1443024323-9115-2-git-send-email-wens@csie.org>
References: <1443024323-9115-1-git-send-email-wens@csie.org>
 <1443024323-9115-2-git-send-email-wens@csie.org>
Message-ID: <20150924065742.GN4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 12:05:17AM +0800, Chen-Yu Tsai wrote:
> Reduced Serial Bus is a proprietary 2-line push-pull serial bus supporting
> multiple slave devices. It was developed by Allwinner, Inc. and used by
> Allwinner and X-Powers, Inc. for their line of PMICs and other peripheral
> ICs.
> 
> Recent Allwinner SoCs, starting with the A23, have an RSB controller. This
> is used to talk to the PMIC, and later with the A80 and A83 platform, the
> audio codec IC.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150924/92234b63/attachment.sig>
