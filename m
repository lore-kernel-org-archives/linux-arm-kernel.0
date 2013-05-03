From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 23:09:16 +0200
Subject: [PATCH 27/63] ARM: ux500: Pass remnant platform data though to
 DMA40 driver
In-Reply-To: <1367591569-32197-28-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-28-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ_cnneFWtinO1dPz0Ky=29aKG=wHW447cHoE8Hnok=xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Ironically, in order to remove lots of the auxdata assignments, we have
> to add just one more. A lot of them require DMA information to be passed
> into clients for DMA channel allocation, but we now have this capability
> in Device Tree. However, the DMA40 driver still relies on a reverse table
> look-up to obtain DMA addresses. Until all of the clients are converted,
> over to the new API, we're stuck with this.
>
> Also, now the DMA40 has been DT:ed, there's no requirement to register
> it using traditional methods, so let's remove it.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-dma40 branch.

Thanks!
Linus Walleij
