From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:33:15 +0200
Subject: [PATCH 04/63] ARM: ux500: Supply MMC DMA configuration via Device
 Tree
In-Reply-To: <1367591569-32197-5-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-5-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZEYKPeutHjs7UfSGmjQQvafp1nV-ZR6DBLWZ0-oVfa_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When requesting a channel, a DMA client needs to pass some pieces of
> information such as; request channel, device type, channel type and
> direction etc. Normally we do this in the form of platform data, but
> when DT is enabled we need to pass it using the driver's bindings
> instead.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied to my ux500-devicetree branch.

Thanks!
Linus Walleij
