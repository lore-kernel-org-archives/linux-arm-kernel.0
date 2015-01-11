From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jan 2015 22:36:34 +0100
Subject: [PATCH v4 5/7] ARM: zynq: Enable pinctrl
In-Reply-To: <1420818231-13451-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
 <1420818231-13451-6-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdam4x-cWjrDuWS-0oDD3eGq1_pD3bK6xWEffiOipfBcOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 9, 2015 at 4:43 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Select pinctrl and the Zynq pinctrl driver.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Tested-by: Andreas F?rber <afaerber@suse.de>
> ---
> Changes since RFC v2:
>  - separate mach-zynq changes in their own patch

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Since we're only selecting some symbols and these will appear
in the merge window this can be applied orthogonally in the Zynq
tree target for ARM SoC.

Yours,
Linus Walleij
