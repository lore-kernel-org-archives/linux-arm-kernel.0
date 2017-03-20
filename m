From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 09:58:08 +0100
Subject: [PATCH] clk: sunxi-ng: Fix div/mult settings for osc12M on A64
In-Reply-To: <1489577038-34773-1-git-send-email-philipp.tomsich@theobroma-systems.com>
References: <1489577038-34773-1-git-send-email-philipp.tomsich@theobroma-systems.com>
Message-ID: <20170320085808.ofixt6jacim3rzuj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 12:23:58PM +0100, Philipp Tomsich wrote:
> The mult/div for osc12M was previously backwards (giving a 48M rate
> for osc12M). Fix it.
> 
> X-AffectedPlatforms: A64-uQ7
> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> Tested-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

I dropped your extra tag, and queued it for 4.11, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/67e3347c/attachment-0001.sig>
