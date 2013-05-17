From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 09:53:57 +0800
Subject: [PATCH 16/20] ARM: mxs: Remove init_irq declaration in machine
 description
In-Reply-To: <1368545933-7430-17-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368545933-7430-17-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130517015355.GB3893@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 05:38:49PM +0200, Maxime Ripard wrote:
> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
> specified") removed the need to explictly setup the init_irq field in
> the machine description when using only irqchip_init. Remove that
> declaration for mxs as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.
