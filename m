From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 5 Jun 2017 15:52:43 +0200
Subject: [PATCH v2 0/2] ARM/arm64: sunxi: convert CCU raw numbers to macros
In-Reply-To: <20170605090033.31663-1-wens@csie.org>
References: <20170605090033.31663-1-wens@csie.org>
Message-ID: <20170605135243.6mznky5jiri7wd2x@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 05:00:31PM +0800, Chen-Yu Tsai wrote:
> Hi Maxime,
> 
> This is a fixed version of my "convert CCU raw numbers to macros" series.
> Please take these instead.
> 
> Changes since v1:
> 
>   - Fixed incorrect macro name for IR reset control phandle
> 
>   - Fixed header filename typo
> 
> These are some clean up patches for 4.12. They convert raw number
> references for the CCU and R_CCU nodes, from when the CCU/R_CCU stuff
> was first added, to the defined macros in the device tree header files.
> 
> These affect the A64 and H3/H5.
> 
> These are based on our sunxi/fixes-for-4.12 branch. Once these are merged,
> I think it's time to send off pull requests for our fixes branches.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170605/ba374f62/attachment.sig>
