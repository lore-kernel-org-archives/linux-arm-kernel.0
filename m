From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Aug 2013 13:19:33 +0800
Subject: [PATCH] ARM: mach-mxs: Remove "TO" string from revision field
In-Reply-To: <1376400482-23442-1-git-send-email-festevam@gmail.com>
References: <1376400482-23442-1-git-send-email-festevam@gmail.com>
Message-ID: <20130814051931.GH16915@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 10:28:02AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> There is no need to print the silicon revision as "TO1.2", just print it as 
> "1.2" instead:
> 
> $ cat /sys/bus/soc/devices/soc0/revision
> 1.2
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
