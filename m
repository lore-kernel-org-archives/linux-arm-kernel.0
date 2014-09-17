From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 17 Sep 2014 18:25:07 +0200
Subject: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <54197C99.8030601@hurleysoftware.com>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-10-git-send-email-bigeasy@linutronix.de>
 <20140911111721.GB17476@xps8300> <54118AAB.2010205@linutronix.de>
 <5411967A.6090406@hurleysoftware.com> <54119AAA.9080907@linutronix.de>
 <5411B33F.10405@hurleysoftware.com> <54171B85.5060209@linutronix.de>
 <54186B89.8050505@linutronix.de> <54197C99.8030601@hurleysoftware.com>
Message-ID: <5419B5E3.10307@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2014 02:20 PM, Peter Hurley wrote:
>> So I connected my am335x-evm
>> with beagle board xm because both of them have an old fashion UART
>> connector (instead those uart-to-usb). Both configured with HW-Flow and
>> I haven't seen the function invoked but I saw "port->icount.overrun"
>> being incremented. This shouldn't happen. So I am a little puzzled here?
> 
> Yeah, that's weird. Do you have a break-out box to confirm that RTS/CTS are
> being driven?

Yeah, I've been thinking about that, too. I will be gone next week and
hopefully when I get back I will something around to test this.

> 
> Regards,
> Peter Hurley
> 

Sebastian
