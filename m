From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jun 2017 10:14:23 +0200
Subject: [PATCH 0/2] ARM/arm64: sunxi: convert CCU raw numbers to macros
In-Reply-To: <20170605043224.20687-1-wens@csie.org>
References: <20170605043224.20687-1-wens@csie.org>
Message-ID: <20170605081423.sx7qqjq73646enlm@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 12:32:22PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> These are some clean up patches for 4.12. They convert raw number
> references for the CCU and R_CCU nodes, from when the CCU/R_CCU stuff
> was first added, to the defined macros in the device tree header files.
> 
> These affect the A64 and H3/H5.
> 
> These are based on our sunxi/fixes-for-4.12 branch. Once these are merged,
> I think it's time to send off pull requests for our fixes branches.
> 
> ChenYu

Applied both, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/8ff9da64/attachment.sig>
