From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 29 May 2014 15:51:50 +0800
Subject: [PATCH] ARM: imx: defconfig: Select CONFIG_FHANDLE
In-Reply-To: <1400851657-32442-1-git-send-email-festevam@gmail.com>
References: <1400851657-32442-1-git-send-email-festevam@gmail.com>
Message-ID: <20140529075149.GE8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:27:37AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> CONFIG_FHANDLE=y is needed when running systemd with version >=210, so that it
> can spawn a serial tty via getty.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
