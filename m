From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 8 Nov 2015 10:11:04 -0600
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
Message-ID: <563F7418.4050203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
> -#define ACPI_MAX_IRQS		256
> +#define ACPI_MAX_IRQS		1020

Why 1020?  Why not 1024?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
