From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Nov 2012 14:57:08 +0800
Subject: [PATCH 6/9] ARM: remove mach .handle_irq for GIC users
In-Reply-To: <1353466713-18967-7-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-7-git-send-email-robherring2@gmail.com>
Message-ID: <20121122065705.GD24693@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 08:58:30PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that the GIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
...
> Cc: Shawn Guo <shawn.guo@linaro.org>
...
>  arch/arm/mach-imx/mach-imx6q.c             |    1 -

Acked-by: Shawn Guo <shawn.guo@linaro.org>
