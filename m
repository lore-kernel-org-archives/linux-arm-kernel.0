From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 22:13:22 +0200
Subject: [PATCH 16/63] ARM: ux500: Remove superfluous 'psize' attribute
 from Audio platform data
In-Reply-To: <1367591569-32197-17-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-17-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYPDnvb+_TEf63NsW8ra0ciWAHmp-VHiXPumFJbL=PNXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> 'psize' is used to calculate the maximum DMA burst size. However it
> is only taken into consideration when editing the DMA channel's
> configuration. The Audio DMA platform data is only used to allocate
> a channel, not configure it. That will be done at a later date within
> the MSP driver.
>
> We're also removing comments which are no longer required, as
> 'data_width' is no longer set in any device's platform data period.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Fabio: as I know you have audio working on the ux500
with the mainline driver: could you confirm that this patch
does not disturb the audio playback and provide a
Tested-by?

Yours,
Linus Walleij
