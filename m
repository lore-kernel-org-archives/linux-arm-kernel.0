From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 2 Nov 2015 07:27:19 -0600
Subject: [PATCH DRAFT 1/2] drivers: serial: PL011: refactor register access
In-Reply-To: <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
 <1446467042-24494-2-git-send-email-andre.przywara@arm.com>
Message-ID: <563764B7.6040202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andre Przywara wrote:
> * to support UARTs with different register offsets (ZTE)
> * to support a different bus access width (16 bits vs. 32 bits)

How exactly does this patch provide this?  The code is still calling a 
fixed function.  How will the code dynamically call a 32-bit version 
instead of a 16-bit version on platforms that need it?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
