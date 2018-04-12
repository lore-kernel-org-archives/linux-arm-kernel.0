From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Apr 2018 11:04:57 +0200
Subject: [PATCH v7 3/9] pinctrl: actions: Add Actions S900 pinctrl driver
In-Reply-To: <20180404172258.7678-4-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org>
 <20180404172258.7678-4-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdZPOSDenSORGVLPuJKPP_iE97mZLXHJLcF2kH5wKPw=tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
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

Patch applied for v4.18

GOOD WORK!

We really need to get this in so that Andreas can work on S500
patches with this as a base.

If any review comments still remain they can surely be addressed
with incremental improvement patches.

Yours,
Linus Walleij
