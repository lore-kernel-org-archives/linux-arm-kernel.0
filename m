From: konkers@google.com (Erik Gilling)
Date: Thu, 18 Mar 2010 09:40:19 -0700
Subject: [RFC/PATCH 00/10] Tegra2 support
In-Reply-To: <20100318083220.GA8267@n2100.arm.linux.org.uk>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<20100318083220.GA8267@n2100.arm.linux.org.uk>
Message-ID: <4344f3c71003180940k7225b96bp9ef6ec54f9c64bef@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 1:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 15, 2010 at 11:41:18PM -0700, konkers at google.com wrote:
>> Here's the cleaned up patch stack as promised. ?We've incorporated the feedback
>> from Gary and Russel.
>>
>> I've pushed these patches to the linux-tegra-2.6.34-rc1 branch at
>> git://android.git.kernel.org/kernel/tegra.git
>
> Please change all the mach/io.h and asm/io.h to linux/io.h, and mach/gpio.h
> and asm/gpio.h to linux/gpio.h.

Thanks,  Will do.

-Erik
