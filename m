From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 17:11:40 +0200
Subject: [PATCH 0/3] pinctrl: qcom: Add IPQ8064 pinctrl support
In-Reply-To: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
References: <1397531437-9104-1-git-send-email-agross@codeaurora.org>
Message-ID: <CACRpkdZ_TgS2XFHyEhkWTHsgdv-Yw2jj9342nDihiJjjGPh7Bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 5:10 AM, Andy Gross <agross@codeaurora.org> wrote:

> This set of patches adds pinctrl support for the Qualcomm IPQ8064 platform.
> The IPQ8064 uses the same TLMM block as the APQ8064, but has a different number
> of pins, functions, and function assignments.  The second patch contains the
> devicetree documentation.  The last patch selects PINCTRL for all ARCH_QCOM
> platforms.  This allows for selection of pinctrl support via a make menuconfig.
>
> Andy Gross (3):
>   pinctrl: qcom: Add definitions for IPQ8064
>   dt: Document Qualcomm IPQ8064 pinctrl binding
>   ARM: qcom: Select PINCTRL by default for ARCH_QCOM

Bj?rn can you look at this series?

David/Bryan: can either of you ACK the changes hitting
arch/arm/mach-qcom/Kconfig
so I can merge this through the pinctrl tree?

Yours,
Linus Walleij
