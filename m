From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Tue, 21 Feb 2017 14:47:45 +0100
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170221122050.421dae48@bbrezillon>
References: <1487593718-20752-1-git-send-email-boris.brezillon@free-electrons.com>
 <1487593718-20752-2-git-send-email-boris.brezillon@free-electrons.com>
 <CAHp75VdwQGP-qa0c0KQwrdpZmCGc3RuEsJ-E-XLbBzQSn4Yxcg@mail.gmail.com>
 <20170220213803.7ba5591e@bbrezillon> <20170220215009.0ecbf5a1@bbrezillon>
 <CAHp75VczsC9WdZWR9iCRh2JoNLFZyOtodrsDRYQoyaN7nkyf=A@mail.gmail.com>
 <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221122050.421dae48@bbrezillon>
Message-ID: <79c21ac6-88ac-c75b-ebcb-aabdd842f6ca@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/02/2017 ? 12:20, Boris Brezillon a ?crit :
>>> (in this case, avr32).  
>> It's dead de facto.
>>
>> When last time did you compile kernel for it? What was the version of kernel?
>> Did it get successfully?

Alexandre answered to this one.

>> When are we going to remove avr32 support from kernel completely?
> I'll let Nicolas answer that one.

It's not up to me to decide this, the community only can decide to
remove the support from the kernel.
What I can tell, and it's been the case for a handful of years now, is
that Atmel/Microchip will not work on this platform anymore and won't
stop a removal of this platform from the Linux kernel.

I know that the dual approach DT/non-DT for some drivers is somehow
painful but I don't see AVR32 moving to DT in the near future...

Regards,
-- 
Nicolas Ferre
