From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Aug 2014 19:33:49 +0200
Subject: [PATCH v2 0/2] ARM: sun8i: Enable pinctrl, i2c and mmc
In-Reply-To: <1408380711-26308-1-git-send-email-wens@csie.org>
References: <1408380711-26308-1-git-send-email-wens@csie.org>
Message-ID: <20140818173349.GD15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 12:51:49AM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This is v2 of the remaining sun8i series. I've dropped the patches you
> merged. The remaining patches have been rebased onto sunxi-next.
> 
> This series enables all the controllers on sun8i that we already have
> drivers for, excluding SPI as the tablet I have does not use it and
> I cannot test it. If there's a way to test it without external connections
> or devices please let me know.
> 
> The commit logs pretty much explain themselves. Note that PLL6 is not
> implemented yet. I've some patches for the clocks that I will send later.

Merged, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/41748379/attachment.sig>
