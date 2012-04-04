From: tsoni@codeaurora.org (Trilok Soni)
Date: Thu, 05 Apr 2012 00:40:01 +0530
Subject: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
In-Reply-To: <1332173578-27422-3-git-send-email-j-pihet@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-3-git-send-email-j-pihet@ti.com>
Message-ID: <4F7C9C89.9080605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

On 3/19/2012 9:42 PM, jean.pihet at newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Move the driver specific macros from the smartreflex header file
> (arch/arm/mach-omap2/smartreflex.h) in a new header file
> include/linux/power/smartreflex.h.
>
> This change makes the SmartReflex implementation ready for the move
> to drivers/.

I wonder why someone would need a new directory under drivers/power 
where the code is not about introducing new and generic AVS framework
but it is all about OMAP specific code. What if tomorrow new generic
AVS framework comes from different chip vendor? I am sure this kind
of technology would be common in newer embedded chips.

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
