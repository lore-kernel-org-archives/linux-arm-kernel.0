From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 21:02:04 +0800
Subject: [PATCH] clk: imx6sl: correct ocram_podf clock type
In-Reply-To: <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
 <1526533248-21990-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180520130203.GB26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 01:00:48PM +0800, Anson Huang wrote:
> IMX6SL_CLK_OCRAM_PODF is a busy divider, its name in
> CCM_CDHIPR register of Reference Manual CCM chapter
> is axi_podf_busy, correct its clock type.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
