From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Sep 2016 14:15:23 +0200
Subject: [RESEND PATCH v2 2/4] pinctrl: amlogic: gxbb: add nand pins
In-Reply-To: <1473779542-2635-2-git-send-email-jbrunet@baylibre.com>
References: <1473779542-2635-1-git-send-email-jbrunet@baylibre.com>
 <1473779542-2635-2-git-send-email-jbrunet@baylibre.com>
Message-ID: <CACRpkda5PZ9UJ8oKVp7rJ3+G1+pt1a_HuGEpfL4zar=zps52MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 13, 2016 at 5:12 PM, Jerome Brunet <jbrunet@baylibre.com> wrote:

> Add EE domains pins for the NAND flash controller.
> Even tough we have no driver for the NAND flash controller yet, we need
> to have these pins in pinctrl as the actual pin are shared with the spifc
> controller. The bootloader on the S905-P200 setup pinmux for the NAND
> controller so we need the kernel to properly deactivate this if necessary.
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied.

Yours,
Linus Walleij
