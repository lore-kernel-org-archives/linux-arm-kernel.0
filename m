From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Sep 2014 07:52:04 -0700
Subject: [PATCH 15/15] tty: serial: 8250: omap: add dma support
In-Reply-To: <54086CA7.8020507@linutronix.de>
References: <53FF84DF.7080406@linutronix.de>
 <20140828225454.GM16006@atomide.com>
 <540048B4.7010807@linutronix.de>
 <20140829161221.GO16006@atomide.com>
 <5404B149.6010400@linutronix.de> <54060EDA.6060204@linutronix.de>
 <20140902201536.GC11766@atomide.com>
 <540745CC.2090901@linutronix.de>
 <20140903174845.GE11766@atomide.com>
 <54086CA7.8020507@linutronix.de>
Message-ID: <20140904145203.GR11766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140904 06:46]:
> On 09/03/2014 07:48 PM, Tony Lindgren wrote:
> 
> I will check this upper part of this email soon?
> 
> > OK. At least it's starting to now sound that the bugs are pretty much
> > the same with 8250 and serial-omap :)
> 
> Do you see a reason for not posting the entire series again since now I
> am bug compatible in the pm-runtime part? We have -rc3 and I would like
> to get this merge the series I have now and this seems to be the only
> problem I am aware of.

Yeah makes sense to me. Thanks for ensuring the bug
compability :)

Regards,

Tony
