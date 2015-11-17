From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 17 Nov 2015 07:36:23 -0600
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and
 reporting
In-Reply-To: <CACRpkdb4Ck4XCUEKX7TEgCg8723vZA-sxqmd753O1q9uTBszfQ@mail.gmail.com>
References: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
 <CACRpkdb4Ck4XCUEKX7TEgCg8723vZA-sxqmd753O1q9uTBszfQ@mail.gmail.com>
Message-ID: <564B2D57.2080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> And I suspect Arnd would be interested to know if you are doing
> ACPI on something that is certainly not a server-class hardware.
> Because you shouldn't.

This driver is for the TLMM pin control device on Qualcomm's ARM64 
Server chip.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
