From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 27 May 2015 18:14:33 -0500
Subject: ARM64 kexec/kdump timeline
In-Reply-To: <2420285.dn5MbvMKXS@wuerfel>
References: <555E37FC.9020800@codeaurora.org>
 <1432239334.1922.7.camel@infradead.org> <55653538.8020206@codeaurora.org>
 <2420285.dn5MbvMKXS@wuerfel>
Message-ID: <55664FD9.1090808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 11:39 AM, Arnd Bergmann wrote:
> ACPI support has just been merged and is still experimental. You
> should be able to boot your system by passing a DT blob at the
> initial boot that matches your hardware. Can you try if that
> makes kexec work?

If I had an initial DT blob that matched by hardware, I wouldn't need 
ACPI support!  This is an ARM64 Server system.  There is no device tree 
for the hardware.  Everything is in ACPI.

What does x86 do?  They don't have device trees, but they do use ACPI, 
so how does kexec work there?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
