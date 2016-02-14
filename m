From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 11:24:33 +0800
Subject: [PATCH v2] ARM: mx25: Add basic suspend/resume support
In-Reply-To: <1454449538-7620-1-git-send-email-festevam@gmail.com>
References: <1454449538-7620-1-git-send-email-festevam@gmail.com>
Message-ID: <20160214032433.GE6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 07:45:38PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Tested basic suspend/resume on a mx25pdk:
> 
> $ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
> $ echo mem > /sys/power/state
> 
> Then press any key in the serial console and the system wakes up.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
