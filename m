From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 13 Dec 2015 09:34:20 -0600
Subject: [PATCH] tty: amba-pl011: add support for 32-bit register access
 for earlycon
In-Reply-To: <20151213060643.GA30667@kroah.com>
References: <1446855503-25881-1-git-send-email-timur@codeaurora.org>
 <20151213060643.GA30667@kroah.com>
Message-ID: <566D8FFC.7080704@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman wrote:
>> >
>> >Example:
>> >
>> >	earlycon=pl011,mmio32,0x3ced1000
>> >
>> >Signed-off-by: Timur Tabi<timur@codeaurora.org>
>> >---
>> >
>> >This patch applies on top of Russell's 12-part amba-pl011.c patchset.
> Which I didn't apply, so can you resend this after he resends his?

Yes, I will resend all of my pl011-releated patches after Russell's 
patches are reworked and accepted.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
