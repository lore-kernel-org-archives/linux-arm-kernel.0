From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 31 Oct 2018 10:43:00 +0100
Subject: [PATCH 0/5] Add Pinctrl and GPIO support for HI3670 SoC
In-Reply-To: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
References: <20181023190655.12004-1-manivannan.sadhasivam@linaro.org>
Message-ID: <CACRpkdbMSYt5aH9fwRijtO=VG1nLAnfxTsfxGza+_Z2iGj2+-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 9:07 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> This patchset adds Pinctrl and GPIO support for HI3670 SoC from HiSilicon
> found in the HiKey970 developement board. Also, the remaining UARTs are
> enabled and GPIO line names are added based on the Schematics and the
> 96Boards Consumer Edition spec.
>
> Note: These patches are based on the below common clk patches pushed
> earlier:
>
> arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
> arm64: dts: hisilicon: Source SoC clock for UART6

All looks good to me.
Acked-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

Yours,
Linus Walleij
