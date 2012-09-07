From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 7 Sep 2012 09:08:30 +0100
Subject: [PATCH 2/2] serial: pl011: delete reset callback
In-Reply-To: <1347004968-15329-1-git-send-email-linus.walleij@stericsson.com>
References: <1347004968-15329-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120907080829.GA6173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:02:48AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Since commit 4fd0690bb0c3955983560bb2767ee82e2b197f9b
> "serial: pl011: implement workaround for CTS clear event issue"
> the PL011 UART is no longer at risk to hang up, so get rid
> of the callback altogether.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Didn't you send these already? Have they changed since?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
