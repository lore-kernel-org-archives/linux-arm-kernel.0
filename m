From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 May 2016 21:12:13 +0200
Subject: [PATCH 0/2] ARM: dts: sunxi: Add display clocks to sun[47]i.dtsi
In-Reply-To: <1462908247-10474-1-git-send-email-plaes@plaes.org>
References: <1462908247-10474-1-git-send-email-plaes@plaes.org>
Message-ID: <20160511191213.GV3733@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 10:24:05PM +0300, Priit Laes wrote:
> Enable the display and TCON clocks that are needed to drive the display
> engine, tcon and TV encoders.
> 
> Please note that currently the parent handling for clocks using 
> 'allwinner,sun4i-a10-display-clk' compatible with number of parents !=4
> is broken (like de_[bf]e[01]_clk clocks present in patches).
> 
> Priit Laes (2):
>   ARM: sun4i: A10: Add display and TCON clocks
>   ARM: sun7i: A20: Add display and TCON clocks

Applied both for 4.8, thanks!
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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160511/291b88ba/attachment.sig>
