From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 06 Jan 2010 12:33:35 +0000
Subject: Arm linux Asymmetric multicore programming
In-Reply-To: <20091229071910.21683.qmail@f6mail-145-191.rediffmail.com>
References: <20091229071910.21683.qmail@f6mail-145-191.rediffmail.com>
Message-ID: <1262781216.18401.0.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-12-29 at 07:19 +0000, pulluru wrote:
> I have an multi-core arm processor. I have a requirement to make core1
> run Linux and to utilize core2(currently in WFI state) for specific
> application, say example: running a network packet engine on core2,
> for increasing performance.
> 
> I am a beginner to arm and kernel programming. I would like to wake-up
> the core2 from WFI state and run my own program.
> 
> Could you please give me some pointers to the linux arch/kernel code
> where the CPU core initialization happens?

You may get some hints on this page:

http://www.linux-arm.org/LinuxBootLoader/SMPBoot

-- 
Catalin
