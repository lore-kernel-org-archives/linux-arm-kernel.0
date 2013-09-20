From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Sep 2013 16:57:50 +0800
Subject: [PATCH 16/26] ARM: mxs: remove custom .init_time hook
In-Reply-To: <1379526839-14798-17-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-17-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130920085748.GB13620@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 07:53:49PM +0200, Sebastian Hesselbarth wrote:
> This patch converts clk-imx2[38] clocksource_of_init compatible init
> associated with fsl,imx2[38]-clkctrl. With arch/arm calling
> of_clk_init(NULL) from time_init(), we can now also remove custom
> .init_time hooks.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Mike Turquette <mturquette@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
