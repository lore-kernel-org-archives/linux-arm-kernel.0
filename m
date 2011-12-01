From: dwalker@fifo99.com (Daniel Walker)
Date: Thu, 01 Dec 2011 10:39:05 -0800
Subject: [PATCH 1/3] ARM: msm: Remove MSM7x00 support
In-Reply-To: <20111201181736.GA13182@huya.qualcomm.com>
References: <1322699344-28422-1-git-send-email-davidb@codeaurora.org>
 <1322752657.3704.2.camel@m0nster>
 <20111201181736.GA13182@huya.qualcomm.com>
Message-ID: <1322764745.3704.9.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-12-01 at 10:17 -0800, David Brown wrote:
> On Thu, Dec 01, 2011 at 07:17:37AM -0800, Daniel Walker wrote:
> > On Wed, 2011-11-30 at 16:29 -0800, David Brown wrote:
> > > -       default ARCH_MSM7X00A
> > > -
> > > -config ARCH_MSM7X00A
> > > -       bool "MSM7x00A / MSM7x01A"
> > > -       select MACH_TROUT if !MACH_HALIBUT
> > > -       select ARCH_MSM_ARM11
> > > -       select MSM_SMD
> > > -       select MSM_SMD_PKG3
> > > -       select CPU_V6
> > > -       select GPIO_MSM_V1
> > > -       select MSM_PROC_COMM
> > > -       select HAS_MSM_DEBUG_UART_PHYS 
> > 
> > 
> > Your trying to drop G1 support ? I have a G1 sitting on my desk, and I
> > know many other people working on the kernel have G1's .. 
> 
> If someone is willing to step up and make it work, then we can keep it
> around.  My only G1 is fried, so I have no way to do anything other
> than keep it compiling.

Unfortunately, You can't remove it regardless of whether or not you have
one to test on.. Your job is to do the best you can to keep it working
and maintained. If you don't have one then you can't boot test but you
still have to your best to keep it as close to working as possible.

Daniel
