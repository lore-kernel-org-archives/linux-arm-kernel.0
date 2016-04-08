From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2016 14:19:37 +0200
Subject: [PATCH v3 04/16] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <1459862860-9775-5-git-send-email-guodong.xu@linaro.org>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
 <1459862860-9775-5-git-send-email-guodong.xu@linaro.org>
Message-ID: <CACRpkdZNTJB_Jn01AwhwHf77yk-Cb_yzj4ty6N1b6wbHmfoevA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 5, 2016 at 3:27 PM, Guodong Xu <guodong.xu@linaro.org> wrote:

> From: Zhong Kaihua <zhongkaihua@huawei.com>
>
> Add Hi6220 gpio configuration nodes
>
> Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
> Signed-off-by: Kong Xinwei <kong.kongxinwei@hisilicon.com>
>

I asked you to remove this blank line.

> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>

(...)
> +++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
> @@ -0,0 +1,607 @@
> +/ {
> +       gpio_rstout_n:gpio_rstout_n {
> +               gpios;
> +       };

I also asked about either explaining or removing this.

Did my mail arrive?

Yours,
Linus Walleij
