From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Jul 2010 10:21:05 +0100
Subject: [PATCH] arm: show_regs dump stack when ARM_UNWIND enable
In-Reply-To: <AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
References: <20100720152431.GA17092@localhost.localdomain>
	<1279640276.10002.35.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimbxrdFeA513Y59OX6y9lwfh3OBjqerazKcwIXx@mail.gmail.com>
Message-ID: <1279704065.17464.1.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-07-20 at 16:54 +0100, ye janboe wrote:
> Yes. both are same.
> 
> Is it ok to remove backtrace.S if ARM_UNWIND is enable?

I think so, as long as you provide some macro or static inline function
for __backtrace and c_backtrace (if they are called at all).

-- 
Catalin
