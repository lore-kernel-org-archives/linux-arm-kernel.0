From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Mon, 30 Oct 2017 15:16:33 +0530
Subject: [PATCH 0/3] arm64: defconfig: remove some Qualcomm USB options
In-Reply-To: <20171025215334.19004-1-elder@linaro.org>
References: <20171025215334.19004-1-elder@linaro.org>
Message-ID: <CAHLCerNhFafnBHXOvfjc-EAds+WCx=Eom9fx2GqMhM+X3R+v9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 26, 2017 at 3:23 AM, Alex Elder <elder@linaro.org> wrote:
> This series deletes three config options related to USB on Qualcomm
> SoCs from the arm64 "defconfig".  The code enabled by the options is
> no longer needed by any Qualcomm hardware.
>
>                                         -Alex


Shouldn't we remove the driver code too in the case that no HW actually uses it?

> Alex Elder (3):
>   arm64: defconfig: remove CONFIG_USB_EHCI_MSM
>   arm64: defconfig: remove CONFIG_USB_MSM_OTG
>   arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY
>
>  arch/arm64/configs/defconfig | 3 ---
>  1 file changed, 3 deletions(-)
