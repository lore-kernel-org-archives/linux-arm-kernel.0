From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 19:03:10 +0200
Subject: [PATCH 09/39] ARM: ux500: Remove DMA address look-up table
In-Reply-To: <1368611522-9984-10-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-10-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdasU0a_T5rwvRah0VpddrOGardLQkNCMRngUdxOUnSH7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> DMA addresses are now passed as part of the dmaengine API by invoking
> dmaengine_slave_config(). So there's no requirement for the DMA40
> driver to look them up in a table provided by platform data. This
> method does not fit in well using Device Tree either.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Good riddance. Patch tentatively applied.
Awaiting Vinod's ACK for include/platform_data/*.

Yours,
Linus Walleij
