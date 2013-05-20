From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 20 May 2013 14:18:56 +0800
Subject: [PATCH] ARM: i.MX6: clk: add different DualLite MLB clock config
In-Reply-To: <1368861928-16141-1-git-send-email-dirk.behme@gmail.com>
References: <1368861928-16141-1-git-send-email-dirk.behme@gmail.com>
Message-ID: <20130520061854.GJ25113@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 18, 2013 at 09:25:28AM +0200, Dirk Behme wrote:
> The CCM_CBCMR register (address 0x02C4018) has different meaning
> between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.
> 
> Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
> i.MX6 Solo/DualLite reuses the gpu2d_core bits for the MLB clock
> configuration.
> 
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Applied, thanks.
