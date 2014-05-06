From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 May 2014 12:41:46 -0700
Subject: [PATCH] ARM: debug: qcom: make UART address selection
 configuration option
In-Reply-To: <1397483254-3612-1-git-send-email-iivanov@mm-sol.com>
References: <53458708.40702@codeaurora.org>
 <1397483254-3612-1-git-send-email-iivanov@mm-sol.com>
Message-ID: <20140506194146.GG20486@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> 
> Separate Qualcomm low-level debugging UART to two options.
> 
> DEBUG_MSM_UART is used in earlier non-multi platform arches,
> like MSM7X00A, QSD8X50 and MSM7X30.
> 
> DEBUG_QCOM_UARTDM is used in multi-plafrom arches and have
> embedded data mover.
> 
> Make DEBUG_UART_PHYS and DEBUG_UART_BASE user adjustable by
> Kconfig menu.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> ---

Finally got around to testing this out.

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
