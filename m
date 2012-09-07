From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Sep 2012 10:58:04 +0100
Subject: [PATCH 1/2] serial: pl011: delete dangling bug flag
In-Reply-To: <1347004956-15294-1-git-send-email-linus.walleij@stericsson.com>
References: <1347004956-15294-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120907095803.GF6173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:02:36AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The bug flag .interrupt_may_hang is not used since commit
> 4fd0690bb0c3955983560bb2767ee82e2b197f9b
> "serial: pl011: implement workaround for CTS clear event issue"
> so delete it.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
