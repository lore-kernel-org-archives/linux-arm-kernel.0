From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 8 Nov 2015 18:05:48 -0600
Subject: [PATCH] acpi: add support for extended IRQ to PCI link
In-Reply-To: <563FE2F5.3050802@codeaurora.org>
References: <1446998832-7023-1-git-send-email-okaya@codeaurora.org>
 <563F7418.4050203@codeaurora.org> <563FE2F5.3050802@codeaurora.org>
Message-ID: <563FE35C.6020504@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
>>
> 1020 is the maximum interrupt ID that can be directed to an ARM SPI
> interrupt according to ARM architecture.

IMHO, that's something that belongs in the patch description.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
