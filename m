From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 18:22:53 +0100
Subject: [PATCH] ASoC: sun4i-spdif: Add support for the H3 SoC
In-Reply-To: <20170112164516.15877-1-codekipper@gmail.com>
References: <20170112164516.15877-1-codekipper@gmail.com>
Message-ID: <20170112172253.746ipbhes5s7xs2k@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 05:45:16PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The H3 SoC uses the same SPDIF block as found in earlier SoCs, but its
> TXFIFO is mapped to another address.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

You should also document the new compatible.

Once this is done, you have my:

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/6de91701/attachment.sig>
