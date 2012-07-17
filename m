From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 17 Jul 2012 14:01:30 +0200
Subject: [PATCH] irqdomain: let the output of irq number align from left
 side
In-Reply-To: <1342514230-8729-1-git-send-email-jason77.wang@gmail.com>
References: <1342514230-8729-1-git-send-email-jason77.wang@gmail.com>
Message-ID: <20485.21530.841814.172762@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Hui Wang writes:
> Except irq number, the rest columns all align from left side, the
> output is ugly as following shows,
> irq    hwirq    chip name        chip data   domain name
>    29  0x0001d  GIC              0x805e1070  /interrupt-<snip>
>    34  0x00022  GIC              0x805e1070  /interrupt-<snip>
> 
> After applying the fix, the output like that,
> irq    hwirq    chip name        chip data   domain name
> 29     0x0001d  GIC              0x805e1070  /interrupt-<snip>
> 34     0x00022  GIC              0x805e1070  /interrupt-<snip>
> 
I prefer numbers to be right aligned, because that makes numbers with
different numbers of digits easier to read.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
