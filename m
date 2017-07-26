From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Jul 2017 10:32:42 +0200
Subject: [PATCH v2 0/9] mfd: axp20x: Add basic support for AXP813
In-Reply-To: <20170726082832.16789-1-wens@csie.org>
References: <20170726082832.16789-1-wens@csie.org>
Message-ID: <20170726083242.k35gnk22h35as55n@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 04:28:23PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v2 of my AXP813 support series. The device tree patches are
> based on my A83T MMC support series. These will go through the sunxi
> tree. The dt-binding and mfd patches are based on v4.13-rc1. These
> will go through Lee's mfd tree.
> 
> Changes since v1:
> 
>   - Provided relative path for ac100.txt in dt-bindings/mfd/axp20x.txt
> 
>   - Added Rob's acks to dt-binding patches
> 
>   - Added Quentin's "mfd: axp20x: use correct platform device id for
>     many PEK" patch to this series. This patch depends on mfd changes
>     in this series. It is included so Lee can take them together in
>     one go.
> 
>   - Added Lee's mfd-acks to mfd patches
> 
>   - Added axp818 compatible with axp813 fallback. The two chips are
>     identical except for the markings. The added compatible matches
>     what is actually on the board, to avoid confusing readers.
> 
>   - Fixed up device tree patches to mention which board is changed
> 
>   - Added device tree patches for the H8 homlet

For the whole serie,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170726/8696d85a/attachment.sig>
