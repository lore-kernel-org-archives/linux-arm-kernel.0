From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 20:06:54 +0100
Subject: [linux-sunxi][PATCH] clk: sunxi-ng: A31: Fix spdif clock register
In-Reply-To: <20161220104446.22638-1-codekipper@gmail.com>
References: <20161220104446.22638-1-codekipper@gmail.com>
Message-ID: <20161220190654.jkfzwh6suongevfz@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 11:44:46AM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> As the SPDIF was rarely documented on the earlier Allwinner SoCs
> it was assumed that it had a similar clock register to the one
> described in the H3 User Manual.
> 
> However this is not the case and it looks to shares the same setup
> as the I2S clock registers.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/632bbf56/attachment.sig>
