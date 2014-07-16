From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 16 Jul 2014 10:22:26 +0200
Subject: [PATCH 1/6] tty: serial: 8250 core: provide a function to export
 uart_8250_port
In-Reply-To: <CAMFK0gtLHrYzWipw=9rp-cUZrKkzBAn_iXSetn016F7zvuZE0w@mail.gmail.com>
References: <1404928177-26554-1-git-send-email-bigeasy@linutronix.de>	<1404928177-26554-2-git-send-email-bigeasy@linutronix.de>
 <CAMFK0gtLHrYzWipw=9rp-cUZrKkzBAn_iXSetn016F7zvuZE0w@mail.gmail.com>
Message-ID: <53C63642.7080208@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 04:30 PM, Olivier Galibert wrote:
> On Wed, Jul 9, 2014 at 7:49 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> + * The lock assumption made here is none because runtime-pm suspend/resume
>> + * callbacks should not be invoked there is any operation performed on the port.
> 
> I think there's a missing "if"?

Thanks, fixed up.

> Best,
> 
>   OG.
> 

Sebastian
