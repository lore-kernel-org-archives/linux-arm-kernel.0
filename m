From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Jul 2012 17:11:40 +0800
Subject: [PATCH] pinctrl: pinctrl-imx: only print debug message when
 DEBUG is defined
In-Reply-To: <1340273435-7530-1-git-send-email-b29396@freescale.com>
References: <1340273435-7530-1-git-send-email-b29396@freescale.com>
Message-ID: <20120706091139.GA28264@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 06:10:35PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Fix regression for commit 3a86a5f8 (pinctrl: pinctrl-imx: free allocated
> pinctrl_map structure only once and use kernel facilities for IMX_PMX_DUMP)
> introduced in 3.5-rc3.
> With above commit, the debug code will alway be excuted.
> Change to excute it only when DEBUG is defined.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> Hopefully it can catch 3.5.
> ---
>  drivers/pinctrl/pinctrl-imx.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
Ping.

Regards
Dong Aisheng
