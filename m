From: napohybelskurwysynom2010@gmail.com (Zimny Lech)
Date: Thu, 21 Oct 2010 13:11:19 +0200
Subject: [RFC] Removal of dead code from arch/arm/*
In-Reply-To: <AANLkTik=27zjJacQTQhd6E4rGuERg19rAd5cgnLTDEoR@mail.gmail.com>
References: <AANLkTim+vj_OAd22TdThuC-HSqUiDjguOHQWjyqFaq6N@mail.gmail.com>
	<AANLkTi=Cpq2_vV2RGcoQhrqk8xpL59AvLFPzfvTBk5Xa@mail.gmail.com>
	<4CBF8BDB.7090907@gmail.com>
	<20101021075401.GC22100@n2100.arm.linux.org.uk>
	<AANLkTikjByC1_BQvPv=Stkdph1cV=a8CwcqrcBv6u0+p@mail.gmail.com>
	<AANLkTik=27zjJacQTQhd6E4rGuERg19rAd5cgnLTDEoR@mail.gmail.com>
Message-ID: <AANLkTimHWtJDV+ZkRnLY5sPmBGC-Z9wHaZwT2KBAN2nv@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/21 Zimny Lech <napohybelskurwysynom2010@gmail.com>:
> 2010/10/21 Zimny Lech <napohybelskurwysynom2010@gmail.com>:
>> I tried to cross compile allyesconfig to test my changes and I hit this
>> ?CC ? ? ?drivers/gpio/janz-ttl.o
>> drivers/gpio/janz-ttl.c: In function ?ttl_set_value?:
>> drivers/gpio/janz-ttl.c:107: error: implicit declaration of function
>> ?iowrite16be?
>
> Another build error not caused by my patch AFAICS
>
> ?CC ? ? ?drivers/input/touchscreen/eeti_ts.o
> drivers/input/touchscreen/eeti_ts.c: In function ?eeti_ts_irq_active?:
> drivers/input/touchscreen/eeti_ts.c:65: error: implicit declaration of
> function ?irq_to_gpio?
>

Another one

  CC      drivers/mfd/ezx-pcap.o
drivers/mfd/ezx-pcap.c: In function ?pcap_isr_work?:
drivers/mfd/ezx-pcap.c:214: error: implicit declaration of function
?irq_to_gpio?



-- 
Slawa!
N.P.S.

Les fleurs du mal unfold
Comme les fleurs du mal
Dark demons of my soul
Un amour fatal
