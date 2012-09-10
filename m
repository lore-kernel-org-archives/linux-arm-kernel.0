From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Sep 2012 17:45:20 +0100
Subject: [PATCH 06/22] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <CACRpkdb09UnPj6xV-rNxoeUS2yPLurA+n6zygWEA3_7OQfb0nA@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdb09UnPj6xV-rNxoeUS2yPLurA+n6zygWEA3_7OQfb0nA@mail.gmail.com>
Message-ID: <20120910164518.GE24506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ola poke.

On Tue, Aug 14, 2012 at 10:55:59AM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Register both parts of the MSP driver from Device Tree so that they
> > are probed when Device Tree is enabled. Also, as there is platform
> > data involved, we ensure that there is allocated memory to place the
> > configuration into and that the correct information is extracted from
> > the DT binary.
> >
> > CC: alsa-devel at alsa-project.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Looks like it's doing what's intended...
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
