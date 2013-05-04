From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 4 May 2013 23:20:36 +0800
Subject: [PATCH] ARM: i.MX6: clk: add i.MX6 DualLite differences
In-Reply-To: <1367572125-28420-1-git-send-email-dirk.behme@de.bosch.com>
References: <1367572125-28420-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20130504152034.GC1749@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 11:08:45AM +0200, Dirk Behme wrote:
> The CCM_CBCMR register (address 0x02C4018) has different meaning
> between the i.MX6 Quad/Dual and the i.MX6 Solo/DualLite.
> 
> Compared to the i.MX6 Quad/Dual, the CCM_CBCMR register in the
> i.MX6 Solo/DualLite doesn't have a gpu3d_shader configuration and
> moves the gpu2_core configuration at that place.
> 
> Handle these i.MX6 Quad/Dual vs. i.MX6 Solo/DualLite clock differences
> by using cpu_is_mx6dl().
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thanks.
