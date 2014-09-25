From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 25 Sep 2014 11:24:46 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140922074605.GB26114@xps8300>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5419B825.5000201@linutronix.de> <20140919102212.GA31784@xps8300>
 <541C0C64.5010206@linutronix.de> <20140922074605.GB26114@xps8300>
Message-ID: <20140925092446.GC19396@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Heikki Krogerus | 2014-09-22 10:46:05 [+0300]:

>Well, there are no other SoCs at the moment that would need it, and
>it's actually possible that there never will be. So yes, just handle
>that also in the omap specific code.

Okay. So let me move the irq routine and the workarounds into omap then.

>Thanks,
>

Sebastian
