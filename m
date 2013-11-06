From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Nov 2013 12:10:34 +0000
Subject: [PATCH 04/13] ARM: ux500: Add DMA config bindings for MSP devices
In-Reply-To: <CACRpkdaNy_h60FJYyTmxVFR8V87znP6KtzY48VhA7jHDTziAcw@mail.gmail.com>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-5-git-send-email-lee.jones@linaro.org>
 <CACRpkdaNy_h60FJYyTmxVFR8V87znP6KtzY48VhA7jHDTziAcw@mail.gmail.com>
Message-ID: <20131106121034.GH30901@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 06 Nov 2013, Linus Walleij wrote:

> On Wed, Nov 6, 2013 at 11:16 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Usually I would like to apply this separately to my ux500-dt branch.
> 
> While we should keep patches together for bisectability, the dts
> files is something of an exception in my book since they will
> be moved out of the kernel one day. Anyway, do as you please:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Actually, you can take it if you like, as it makes no difference to
this patch-set. Just make sure it's applied before I rip out the MSP
platform data stuff (which I am yet to do).

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
