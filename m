From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 3 Feb 2013 18:41:16 +0800
Subject: [PATCH] ARM: mxs: Enable cpuidle
In-Reply-To: <1359733797-19538-1-git-send-email-festevam@gmail.com>
References: <1359733797-19538-1-git-send-email-festevam@gmail.com>
Message-ID: <20130203104113.GA26233@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 01:49:57PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Enable CONFIG_CPU_IDLE, so that suspend/resume can be tested on mxs platforms.
> 
I do not think suspend depends on CONFIG_CPU_IDLE to work.  Can you
investigate the root cause why suspend does not work without enabling
CONFIG_CPU_IDLE?

Shawn
