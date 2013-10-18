From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 12:07:23 +0100
Subject: [PATCH 3/5] ARM: ux500: fix clock for GPIO blocks 6 and 7
In-Reply-To: <20131018110557.GW19112@lee--X1>
References: <1382087112-31665-1-git-send-email-linus.walleij@linaro.org>
 <20131018110557.GW19112@lee--X1>
Message-ID: <20131018110723.GY19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Lee Jones wrote:

> On Fri, 18 Oct 2013, Linus Walleij wrote:
> 
> > The clock assignment in the device tree for GPIO blocks 6
> > and 7 was incorrect, indicating this was managed by bit 1 on
> > PRCC 2 while it was in fact bit 11 on PRCC 2.
> 
> Nice catch.
> 
> It's also wrong in the driver:

Sorry, forgot this: Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
