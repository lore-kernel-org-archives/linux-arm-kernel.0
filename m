From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 2 Jun 2010 09:16:18 +0200
Subject: [PATCH 2/2] ARM: PL011 baudrate extension for ST-Ericssons
	derivative
In-Reply-To: <20100601180944.GC6644@n2100.arm.linux.org.uk>
References: <1275385698-1599-1-git-send-email-linus.walleij@stericsson.com>
	<20100601180944.GC6644@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikXGuRm_oUYof6DxWadBGQ8LZCD9rZ5TCW_VZxU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> On Tue, Jun 01, 2010 at 11:48:18AM +0200, Linus Walleij wrote:
>> @@ -90,6 +92,7 @@ static struct vendor_data vendor_arm = {
>> ? ? ? .fifosize ? ? ? ? ? ? ? = 16,
>> ? ? ? .lcrh_tx ? ? ? ? ? ? ? ?= UART011_LCRH,
>> ? ? ? .lcrh_rx ? ? ? ? ? ? ? ?= UART011_LCRH,
>> + ? ? ? ?.oversampling ? ? ? ? ? ? ? ?= false,
>
> I assume these spaces rather than tabs are due to an editor error
> rather than an email client problem?

Yeah it was :-/

I've fixed it up and put the fixed versions in the patch tracker.

(Marcin I have some nice extensions to EMACS that check this as
you code, mail me if you want it.)

Yours,
Linus Walleij
