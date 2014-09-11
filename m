From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 11 Sep 2014 18:04:32 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140911151114.GD28458@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de>
 <20140911151114.GD28458@ci00147.xsens-tech.local>
Message-ID: <5411C810.7070906@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2014 05:11 PM, Frans Klaver wrote:

> I can still reproduce it on am335x. I can get out of it as soon as
> something else gets written to the console though.
> 
> # echo "<3>something" >/dev/kmsg

Is this to stall it or to get out of it?

> 
> Frans

Sebastian
