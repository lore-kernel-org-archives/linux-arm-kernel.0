From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 04 Sep 2014 16:56:20 +0200
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <20140904145203.GR11766@atomide.com>
References: <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com> <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com> <5404B149.6010400@linutronix.de>
 <54060EDA.6060204@linutronix.de> <20140902201536.GC11766@atomide.com>
 <540745CC.2090901@linutronix.de> <20140903174845.GE11766@atomide.com>
 <54086CA7.8020507@linutronix.de> <20140904145203.GR11766@atomide.com>
Message-ID: <54087D94.7000208@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2014 04:52 PM, Tony Lindgren wrote:
> Yeah makes sense to me. Thanks for ensuring the bug
> compability :)

Thanks. What about the ttyOx vs ttySx. Do you want me to add kernel
line fixup somewhere arch/arm or we ignore this for now? Greg didn't
say anything?

> 
> Regards,
> 
> Tony
> 

Sebastian
