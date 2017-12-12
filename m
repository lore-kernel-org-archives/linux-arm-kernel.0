From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Dec 2017 09:35:42 +0100
Subject: [PATCH 1/4] ASoC: sun4i-i2s: Add support for A83T
In-Reply-To: <20171212081148.9194-2-wens@csie.org>
References: <20171212081148.9194-1-wens@csie.org>
 <20171212081148.9194-2-wens@csie.org>
Message-ID: <20171212083542.aue7useyyqvuzohi@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 04:11:45PM +0800, Chen-Yu Tsai wrote:
> The I2S controller in the A83T is mostly compatible with the one found
> in earlier SoCs such as the A20 and A31. While the documents publicly
> available for the A83T do not cover this hardware, the officially
> released BSP kernel does have register definitions for it. These were
> matched against the A20 user manual. The only difference is the TX FIFO
> and interrupt status registers have been swapped around, like what we
> have seen with the SPDIF controller.
> 
> This patch adds support for this hardware.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

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
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/af34a175/attachment.sig>
