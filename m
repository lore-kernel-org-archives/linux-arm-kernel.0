From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2018 11:06:39 +0200
Subject: [PATCH v7 7/9] gpio: Add gpio driver for Actions OWL S900 SoC
In-Reply-To: <20180404172258.7678-8-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
 <20180404172258.7678-8-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdaP68mn6GP5fg8eJMDswAiKRrBF5aLj+coGQraPsS-RMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied for v4.18.

Again: excellent work.

Yours,
Linus Walleij
