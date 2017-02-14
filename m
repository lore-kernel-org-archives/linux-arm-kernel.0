From: rah@settrans.net (Bob Ham)
Date: Tue, 14 Feb 2017 22:20:55 +0000
Subject: [PATCH] clk: sunxi-ng: sun6i: Fix enable bit offset for
 hdmi-ddc module clock
In-Reply-To: <20170214022332.13326-1-wens@csie.org>
References: <20170214022332.13326-1-wens@csie.org>
Message-ID: <1487110855.7145.46.camel@settrans.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-02-14 at 10:23 +0800, Chen-Yu Tsai wrote:
> The enable bit offset for the hdmi-ddc module clock is wrong. It is
> pointing to the main hdmi module clock enable bit.
> 
> Reported-by: Bob Ham <rah@settrans.net>
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Cc: stable at vger.kernel.org # 4.9.x-
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Bob,
> 
> Can you try this patch and see if it fixes your HDMI issue?
> With the kernel running without "clk_ignore_unused" that is.

Hi Chen-Yu,

Unfortunately, that doesn't fix it; I get the same behaviour as without
clk_ignore_unused.

Thanks though,

Bob

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/806a4080/attachment.sig>
