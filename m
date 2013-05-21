From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 21 May 2013 14:01:47 +0800
Subject: [PATCH] ARM i.MX6q: fix for ldb_di_sels
In-Reply-To: <1369054311-2519-1-git-send-email-jiada_wang@mentor.com>
References: <1369054311-2519-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <20130521060145.GG3080@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 09:51:51PM +0900, Jiada Wang wrote:
> As pll5_video_div has been introduced to represent the clock
> generated from post-divider for video.
> Instead of pll5_video, pll5_video_div should be proper root clock
> for ldb_di_sel.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

Applied, thanks.
