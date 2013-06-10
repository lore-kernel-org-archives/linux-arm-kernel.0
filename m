From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Jun 2013 10:17:24 +0100
Subject: [PATCH 06/39] ARM: ux500: Move SDI (MMC) and UART devices under
 more descriptive heading
In-Reply-To: <CACRpkdZ=NJR3VRNJE2pSTJ8t1VCMq+wjH_s0NOi4AHko3no_KA@mail.gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdZ=NJR3VRNJE2pSTJ8t1VCMq+wjH_s0NOi4AHko3no_KA@mail.gmail.com>
Message-ID: <20130610091724.GG20297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 May 2013, Linus Walleij wrote:

> On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Now DMA DT bindings exist and are in use by he MMC and UART drivers, it
> > should be possible to remove them from the auxdata structure. However,
> > after doing so the drivers fail. Common clk is still reliant on the
> > dev_name() call to do device name matching, which will fail due to the
> > fact that Device Tree naming differs somewhat do the more traditional
> > conventions.
> >
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Cannot be applied due to dependency on 5/39.

I think this can be applied now (if it hasn't already).

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
