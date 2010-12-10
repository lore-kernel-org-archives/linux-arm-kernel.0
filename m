From: wim@iguana.be (Wim Van Sebroeck)
Date: Fri, 10 Dec 2010 14:18:37 +0100
Subject: [PATCH v2] watchdog: imx: use clk_get to acquire the watchdog
	clock
In-Reply-To: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
References: <1291738564-10374-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20101210131837.GA3783@infomag.iguana.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

> Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Wim Van Sebroeck <wim@iguana.be>

Since this looks more arch specific, can this go via the arm kernel tree?

Thanks in advance,
Wim.
