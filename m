From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 25 Jun 2013 00:38:17 +0200
Subject: [RFC PATCH v2 09/12] clk: samsung: s3c64xx: Add aliases for DMA
 clocks
In-Reply-To: <1371933764-24875-10-git-send-email-tomasz.figa@gmail.com>
References: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
 <1371933764-24875-10-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZ0WZ03XsNNx_e1zNuu_Mqkh6cyi0cV3PrzD1LxD0s63g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 10:42 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> The new amba-pl08x driver requires another set of clock aliases, so this
> patch adds them.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  drivers/clk/samsung/clk-s3c64xx.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
> index 253a972..9fb750c 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c

This driver is not in my kernel mainline tree or linux-next,
is it pending in some review?

Yours,
Linus Walleij
