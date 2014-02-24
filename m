From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Feb 2014 10:55:41 +0800
Subject: [patch 08/26] arm: Replace various irq_desc accesses
In-Reply-To: <20140223212737.099151500@linutronix.de>
References: <20140223212703.511977310@linutronix.de>
 <20140223212737.099151500@linutronix.de>
Message-ID: <20140224025539.GE25011@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 09:40:12PM -0000, Thomas Gleixner wrote:
> Use the proper functions. There is no need to fiddle with irq_desc.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
...
>  arch/arm/mach-imx/pm-imx6q.c        |    7 +++----

Acked-by: Shawn Guo <shawn.guo@linaro.org>
