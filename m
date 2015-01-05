From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Jan 2015 21:35:04 +0800
Subject: [PATCH V2] ARM: imx: support arm power off in cpuidle for i.mx6sx
In-Reply-To: <1418790252-12947-1-git-send-email-b20788@freescale.com>
References: <1418790252-12947-1-git-send-email-b20788@freescale.com>
Message-ID: <20150105133502.GG24511@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 12:24:12PM +0800, Anson Huang wrote:
> This patch introduces an independent cpuidle driver for
> i.MX6SX, and supports arm power off in idle, totally
> 3 levels of cpuidle are supported as below:
> 
> 1. ARM WFI;
> 2. SOC in WAIT mode;
> 3. SOC in WAIT mode + ARM power off.
> 
> ARM power off can save at least 5mW power.
> 
> This patch also replaces imx6q_enable_rbc with imx6_enable_rbc.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks. 
