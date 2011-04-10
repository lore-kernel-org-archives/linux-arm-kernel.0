From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 10 Apr 2011 10:05:46 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <20110410080159.GB2798@ucw.cz>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop> <20110410080159.GB2798@ucw.cz>
Message-ID: <BANLkTikL+GvaKN6nT-9WjpPjaJz0dR51KQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/10 Pavel Machek <pavel@ucw.cz>:
> Hi!
>
>
>> >@@ -0,0 +1,30 @@
>> >+config BCMAI_POSSIBLE
>> >+ ? ? ? bool
>> >+ ? ? ? depends on HAS_IOMEM && HAS_DMA
>> >+ ? ? ? default y
>> >+
>> >+menu "Broadcom's AI"
>> >+ ? ? ? depends on BCMAI_POSSIBLE
>> >+
>> >+config BCMAI
>> >+ ? ? ? tristate "AI support"
>> >+ ? ? ? depends on BCMAI_POSSIBLE
>> >+
>> >+config BCMAI_HOST_PCI_POSSIBLE
>> >+ ? ? ? bool
>> >+ ? ? ? depends on BCMAI && PCI = y
>> >+ ? ? ? default y
>> >+
>> >+config BCMAI_HOST_PCI
>> >+ ? ? ? bool "Support for AI on PCI-host bus"
>> >+ ? ? ? depends on BCMAI_HOST_PCI_POSSIBLE
>> >+
>> >+config BCMAI_DEBUG
>> >+ ? ? ? bool "BCMAI debugging"
>> >+ ? ? ? depends on BCMAI
>> >+ ? ? ? help
>> >+ ? ? ? ? This turns on additional debugging messages.
>> >+
>> >+ ? ? ? ? If unsure, say N
>
> Totally useless ?:-(. It should really explain what AI means in this context.

Feel free to propose sth.

-- 
Rafa?
