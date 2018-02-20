From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Tue, 20 Feb 2018 08:53:22 +0100
Subject: [PATCH 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
In-Reply-To: <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
Message-ID: <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Manivannan,

On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
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


<snip>


> --- /dev/null
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -0,0 +1,2536 @@
> +// SPDX-License-Identifier: GPL-2.0+

<snip>

> +MODULE_LICENSE("GPL v2");

This does not match your license above. Per module.h "GPL v2" means
GPL-2.0 where you license above GPL-2.0+ means or later

-- 
Cordially
Philippe Ombredanne
