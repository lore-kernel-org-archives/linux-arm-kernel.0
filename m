From: janboe.ye@gmail.com (Janboe Ye)
Date: Thu, 22 Jul 2010 01:24:28 +0800
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <1279704065.17464.1.camel@e102109-lin.cambridge.arm.com>
References: <20100720152431.GA17092@localhost.localdomain>
	<1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
	<1279704065.17464.1.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100721172428.GA5881@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Is there any way for arm unwind to do user space backtrace like c_backtrace in arm_syscall?

Thanks

On Wed, Jul 21, 2010 at 10:21:05AM +0100, Catalin Marinas wrote:
> On Tue, 2010-07-20 at 16:54 +0100, ye janboe wrote:
> > Yes. both are same.
> > 
> > Is it ok to remove backtrace.S if ARM_UNWIND is enable?
> 
> I think so, as long as you provide some macro or static inline function
> for __backtrace and c_backtrace (if they are called at all).
> 
> -- 
> Catalin
> 
