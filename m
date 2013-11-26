From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Nov 2013 11:03:13 +0800
Subject: [PATCH v2] ARM i.MX5: fix "shift" value for lp_apm_sel on i.MX50
 and i.MX53
In-Reply-To: <1385399037-15487-1-git-send-email-mkl@pengutronix.de>
References: <1385399037-15487-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20131126030311.GG30476@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 06:03:57PM +0100, Marc Kleine-Budde wrote:
> According to the i.MX50 Rev. 1 and i.MX53 Rev. 2.1 datasheet the lp_apm_sel is
> bit 10 in the CCM_CCSR register not bit 9. On the i.MX51 it's bit 9.
> 
> This patch fixes this issue.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
 
Applied, thanks.
