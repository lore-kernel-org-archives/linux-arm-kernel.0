From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Feb 2018 16:07:51 +0100
Subject: [PATCH v2 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
In-Reply-To: <20180221160044.15089-5-manivannan.sadhasivam@linaro.org>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org>
 <20180221160044.15089-5-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdZNVv1=WngCaXF9Mrmw7e=KugG7gJpYF7mr9RAbcsNu=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 5:00 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> pinctrl, pinmux and pinconf functionalities through a range of registers
> common to both gpio driver and pinctrl driver.
>
> Pinmux functionality is available only for the pin groups while the
> pinconf functionality is available for both pin groups and individual
> pins.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks very good overall.

Can I get Andreas' feedback and ACK on this?

It would be awesome if someone from Actions could also
ACK or drop some comments.

Actions was an early adopter of the pin control framework (it was
used already on ATM7029), so I would appreciate their feedback.

Yours,
Linus Walleij
