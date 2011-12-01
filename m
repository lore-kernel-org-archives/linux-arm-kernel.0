From: dwalker@fifo99.com (Daniel Walker)
Date: Thu, 01 Dec 2011 07:17:37 -0800
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1322752657.3704.2.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-30 at 16:29 -0800, David Brown wrote:
> -       default ARCH_MSM7X00A
> -
> -config ARCH_MSM7X00A
> -       bool "MSM7x00A / MSM7x01A"
> -       select MACH_TROUT if !MACH_HALIBUT
> -       select ARCH_MSM_ARM11
> -       select MSM_SMD
> -       select MSM_SMD_PKG3
> -       select CPU_V6
> -       select GPIO_MSM_V1
> -       select MSM_PROC_COMM
> -       select HAS_MSM_DEBUG_UART_PHYS 


Your trying to drop G1 support ? I have a G1 sitting on my desk, and I
know many other people working on the kernel have G1's .. 

Daniel
