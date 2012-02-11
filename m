From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Feb 2012 22:58:31 -0800
Subject: [PATCH v2 4/4] ARM: remove empty disable_fiq and
 arch_ret_to_user macros
In-Reply-To: <1328751219-2552-5-git-send-email-robherring2@gmail.com>
References: <1328751219-2552-1-git-send-email-robherring2@gmail.com>
 <1328751219-2552-5-git-send-email-robherring2@gmail.com>
Message-ID: <20120211065830.GD2198@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 07:33:39PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that most platforms don't need disable_fiq and arch_ret_to_user
> macros, we can remove the empty macros or empty entry-macro.S files.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Ryan Mallon <rmallon@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
...
>  arch/arm/mach-mxs/include/mach/entry-macro.S       |    6 ----
...
>  arch/arm/plat-mxc/include/mach/entry-macro.S       |   16 -----------
...
>  delete mode 100644 arch/arm/plat-mxc/include/mach/entry-macro.S

Nice.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
