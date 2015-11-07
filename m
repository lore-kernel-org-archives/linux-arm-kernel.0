From: timur@codeaurora.org (Timur Tabi)
Date: Sat, 7 Nov 2015 17:31:29 -0600
Subject: [PATCH] tty: amba-pl011: add options to earlycon for 32-bit reg
 access
In-Reply-To: <563E7CF2.60609@hurleysoftware.com>
References: <1446770267-26749-1-git-send-email-timur@codeaurora.org>
 <563C07C8.9060506@hurleysoftware.com> <563C09BB.9030706@codeaurora.org>
 <563C1409.4070804@hurleysoftware.com> <563CF8AF.50808@codeaurora.org>
 <563E7CF2.60609@hurleysoftware.com>
Message-ID: <563E89D1.4070200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Hurley wrote:
> I'll note that when I review Russell's v2 series, if necessary.
> What is the plan to introduce the SBSA32 support? After the ACPI support is
> upstreamed?

There are some patches from Leif Lindholm that address that.  However, 
they will probably need to be reworked on top of Russell's patch set.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
