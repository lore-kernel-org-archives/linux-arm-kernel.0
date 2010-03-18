From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 08:32:20 +0000
Subject: [RFC/PATCH 00/10] Tegra2 support
In-Reply-To: <1268721688-27550-1-git-send-email-konkers@google.com>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
Message-ID: <20100318083220.GA8267@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 11:41:18PM -0700, konkers at google.com wrote:
> Here's the cleaned up patch stack as promised.  We've incorporated the feedback
> from Gary and Russel.
> 
> I've pushed these patches to the linux-tegra-2.6.34-rc1 branch at
> git://android.git.kernel.org/kernel/tegra.git

Please change all the mach/io.h and asm/io.h to linux/io.h, and mach/gpio.h
and asm/gpio.h to linux/gpio.h.
