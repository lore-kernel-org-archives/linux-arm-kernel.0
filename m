From: tsoni@codeaurora.org (Trilok Soni)
Date: Thu, 05 Apr 2012 12:23:25 +0530
Subject: [PATCH 2/9] ARM: OMAP2+: SmartReflex: move the driver specific
 macros in include/linux/power
In-Reply-To: <4F7CA3E1.2050809@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <1332173578-27422-3-git-send-email-j-pihet@ti.com>
 <4F7C9C89.9080605@codeaurora.org> <4F7CA3E1.2050809@ti.com>
Message-ID: <4F7D4165.2060101@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

>
> The main motivation is that it's a driver and thus does not have
> anything to do inside mach-omap2.

Right, I understood that. mach-omap2 is not suitable for full fledged 
drivers.

>
> Where will you put that otherwise?

Couple of suggestions:

drivers/platform/omap/avs?
drivers/misc/omap/avs?

I prefer first one.

>
> IIRC, David Brownell was referring to the rule of three for such case.
> Meaning that it worth having a generic fmwk when at least three
> different drivers are doing the same kind of things.

Yes, I remember that rule, but that's not stopping us to create a fwk, 
may be others will rise once they see the framework and contribute
if their h/w architecture requirements are not addressed?

---Trilok Soni

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
