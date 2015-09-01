From: slash.tmp@free.fr (Mason)
Date: Tue, 01 Sep 2015 21:01:16 +0200
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E5E970.90801@gmail.com>
References: <55E5CED8.7000408@free.fr> <yw1xtwreysnr.fsf@unicorn.mansr.com>
 <55E5E70D.4060006@free.fr> <55E5E970.90801@gmail.com>
Message-ID: <55E5F5FC.3050605@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2015 20:07, Florian Fainelli wrote:

> On 01/09/15 10:57, Mason wrote:
> 
>> By the way, it seems the generic UART driver does not use interrupts,
>> which would explain why the console works despite my busted device tree.
>> Does that mean that the driver polls? (I'll take a closer look tomorrow.)
> 
> Kernel console is buffer and polled, user-space (tty) console uses
> interrupts.

Thanks for clearing that up.
