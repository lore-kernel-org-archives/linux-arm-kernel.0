From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 9 Jun 2013 16:34:11 +0800
Subject: [PATCH v2] serial: imx: enable the clocks for console
In-Reply-To: <1370743279-15941-1-git-send-email-b32955@freescale.com>
References: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
 <1370743279-15941-1-git-send-email-b32955@freescale.com>
Message-ID: <20130609083409.GA32485@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 10:01:19AM +0800, Huang Shijie wrote:
> The console's clocks are disabled after the uart driver is probed.
> It makes that we can see less log from the console now
> (though we still can get all the log by the `dmesg`).
> 
> So enable the clocks for console, and we can see all the log again.
> 
> This patch also disables the sport->clk_per when we fail to enable
> the sport->clk_ipg;
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Tested-by: Shawn Guo <shawn.guo@linaro.org>
