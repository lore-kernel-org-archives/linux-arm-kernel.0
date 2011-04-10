From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 10 Apr 2011 10:30:53 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <20110410082420.GA1460@localhost.ucw.cz>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop> <20110410080159.GB2798@ucw.cz>
	<BANLkTikL+GvaKN6nT-9WjpPjaJz0dR51KQ@mail.gmail.com>
	<20110410082420.GA1460@localhost.ucw.cz>
Message-ID: <BANLkTim9JTpZGib+_C_vTFFhP5azbGwMjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/10 Pavel Machek <pavel@ucw.cz>:
>> >> >+config BCMAI_HOST_PCI_POSSIBLE
>> >> >+ ? ? ? bool
>> >> >+ ? ? ? depends on BCMAI && PCI = y
>> >> >+ ? ? ? default y
>> >> >+
>> >> >+config BCMAI_HOST_PCI
>> >> >+ ? ? ? bool "Support for AI on PCI-host bus"
>> >> >+ ? ? ? depends on BCMAI_HOST_PCI_POSSIBLE
>> >> >+
>> >> >+config BCMAI_DEBUG
>> >> >+ ? ? ? bool "BCMAI debugging"
>> >> >+ ? ? ? depends on BCMAI
>> >> >+ ? ? ? help
>> >> >+ ? ? ? ? This turns on additional debugging messages.
>> >> >+
>> >> >+ ? ? ? ? If unsure, say N
>> >
>> > Totally useless ?:-(. It should really explain what AI means in this context.
>>
>> Feel free to propose sth.
>
> AFAICT AI means "artifical inteligence". So _you_ really need to fix your kconfig.

I always though of AI as of "American Idiot"... or just one of another
100 meanings: http://en.wikipedia.org/wiki/Ai_(disambiguation)

For a short time we didn't know real name of this bus, we
partially-guessed it to be AI. I can not help the fact this could be
understood as "artifical intelligence".

If you check PATCH V2, we renamed this to (AMBA) AXI. I don't have
better idea so i'll have to stay this way. Unless someone has a better
*proposal*.

-- 
Rafa?
