From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Jun 2015 10:07:57 +0200
Subject: [patch] gpio: Added GPIO support to ZynqMP SoC
In-Reply-To: <1433160019-11157-1-git-send-email-anuragku@xilinx.com>
References: <1433160019-11157-1-git-send-email-anuragku@xilinx.com>
Message-ID: <CACRpkdZpvr4NfH43FvoHdfKaqqDGMHJU5=UHEzOpLV9xC4vaTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 2:00 PM, Anurag Kumar Vulisha
<anurag.kumar.vulisha@xilinx.com> wrote:

> Added support to ZynqMP SoC on the existing zynq gpio driver.
>
> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>

> +static const struct of_device_id zynq_gpio_of_match[] = {
> +       { .compatible = "xlnx,zynq-gpio-1.0", .data = (void *)&zynq_gpio_def },
> +       { .compatible = "xlnx,zynqmp-gpio-1.0",
> +                                       .data = (void *)&zynqmp_gpio_def },

Is there a separate patch adding this to the device tree
bindings in Documentation/devicetree/bindings/gpio/gpio-zynq.txt?

Else please include it in this patch.

Yours,
Linus Walleij
