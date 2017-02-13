From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 13 Feb 2017 12:50:47 -0800
Subject: [PATCH] [v2] pinctrl: qcom: add get_direction function
In-Reply-To: <1486769959-22930-1-git-send-email-timur@codeaurora.org>
References: <1486769959-22930-1-git-send-email-timur@codeaurora.org>
Message-ID: <34a3143d-585d-7786-1b55-650b3bdfe006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/2017 03:39 PM, Timur Tabi wrote:
> The get_direction callback function allows gpiolib to know the current
> direction (input vs output) for a given GPIO.
>
> This is particularly useful on ACPI systems, where the GPIOs are
> configured only by firmware (typically UEFI), so the only way to
> know the initial values to query the hardware directly.  Without
> this function, gpiolib thinks that all GPIOs are configured for
> input.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
