From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Wed, 15 Jul 2015 11:37:35 -0700
Subject: [PATCH] [v2] pinctrl: add support for Qualcomm Technologies
 QDF2xxx ARM64 SoCs
In-Reply-To: <1436978834-7271-1-git-send-email-timur@codeaurora.org>
References: <1436978834-7271-1-git-send-email-timur@codeaurora.org>
Message-ID: <20150715183735.GG32767@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 15 Jul 09:47 PDT 2015, Timur Tabi wrote:

> Add the pinctrl driver for the Qualcomm Technologies QDF2xxx ARM64 SoCs,
> which uses the Qualcomm Technologies TLMM pinctrl/gpio device.  This
> driver is probed via ACPI and uses the pinctrl-msm.c backend driver.
> 
> This driver is intended to be used only an ACPI-enabled system.  As such,
> UEFI will handle all pin control configuration, so this driver does not
> provide pin control functions.  It is effectively a GPIO-only driver.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
