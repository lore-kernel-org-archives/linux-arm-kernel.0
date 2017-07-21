From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 09:21:41 +0200
Subject: [PATCH v2 06/10] mmc: sunxi: Add support for A83T eMMC (MMC2)
In-Reply-To: <20170720034452.15920-7-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-7-wens@csie.org>
Message-ID: <20170721072141.uxvp7c6c5s64akdp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:44:48AM +0800, Chen-Yu Tsai wrote:
> The third MMC controller (MMC2) on the Allwinner A83T SoC is slightly
> different. It supports a wider 8-bit bus, has a dedicated controllable
> reset pin for eMMC, and a "new timing mode" which is supposed to deliver
> better signals and thus better performance.
> 
> Add a compatible for this one to use the new timing mode not found in the
> other controllers.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/6d867a3e/attachment.sig>
