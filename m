From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jun 2018 14:31:54 +0200
Subject: [PATCH v2 3/3] pinctrl: actions: Add interrupt support for OWL
 S900 SoC
In-Reply-To: <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
References: <20180623045954.6729-1-manivannan.sadhasivam@linaro.org>
 <20180623045954.6729-4-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdZcUJBsb-P5eT3PcYe1ukYCU8OC95pBbR58wYXutdT1JQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 23, 2018 at 7:00 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add interrupt support for Actions Semi OWL S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Patch applied with Andy's review tag.

I really like the looks of this!

If you have ideas on how we can move more of the multiple
IRQ parent per-bank IRQ into the core and make it easier to
use, feel free to contribute ideas and code :)

Yours,
Linus Walle?j
