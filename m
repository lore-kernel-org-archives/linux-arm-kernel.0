From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Sep 2015 09:50:56 +0800
Subject: [PATCH] ARM: dts: imx7d: Fix UART2 base address
In-Reply-To: <1443122292-29385-1-git-send-email-festevam@gmail.com>
References: <1443122292-29385-1-git-send-email-festevam@gmail.com>
Message-ID: <20150930015056.GA15771@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2015 at 04:18:12PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The UART2 memory space starts at address 0x30890000 (UART2_URXD).
> 
> Fix it so that UART2 can be used.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
