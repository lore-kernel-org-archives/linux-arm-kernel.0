From: arend@broadcom.com (Arend van Spriel)
Date: Sun, 10 Apr 2011 16:36:10 +0200
Subject: [RFC][PATCH] bcmai: introduce AI driver
In-Reply-To: <BANLkTimgJ--19=q-od7S8uj6T6AcXrtg7w@mail.gmail.com>
References: <1302033463-1846-1-git-send-email-zajec5@gmail.com>
	<op.vtisojsk3ri7v4@arend-laptop> <20110410080159.GB2798@ucw.cz>
	<BANLkTikL+GvaKN6nT-9WjpPjaJz0dR51KQ@mail.gmail.com>
	<20110410082420.GA1460@localhost.ucw.cz>
	<BANLkTim9JTpZGib+_C_vTFFhP5azbGwMjg@mail.gmail.com>
	<op.vtpt6v173ri7v4@arend-laptop>
	<BANLkTimgJ--19=q-od7S8uj6T6AcXrtg7w@mail.gmail.com>
Message-ID: <op.vtp76iua3ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 10 Apr 2011 13:32:43 +0200, Rafa? Mi?ecki <zajec5@gmail.com> wrote:

> W dniu 10 kwietnia 2011 11:33 u?ytkownik Arend van Spriel
> <arend@broadcom.com> napisa?:
>> On Sun, 10 Apr 2011 10:30:53 +0200, Rafa? Mi?ecki <zajec5@gmail.com>  
>> wrote:
>>
>>> 2011/4/10 Pavel Machek <pavel@ucw.cz>:
>>>>>
>>>>> >> >+config BCMAI_HOST_PCI_POSSIBLE
>>>>> >> >+       bool
>>>>> >> >+       depends on BCMAI && PCI = y
>>>>> >> >+       default y
>>>>> >> >+
>>>>> >> >+config BCMAI_HOST_PCI
>>>>> >> >+       bool "Support for AI on PCI-host bus"
>>>>> >> >+       depends on BCMAI_HOST_PCI_POSSIBLE
>>>>> >> >+
>>
>> Hi Rafa?,
>>
>> Could use term AMBA AXI instead which gives enough hits on Google to  
>> hint
>> interested people to more in depth information.
>>
>> FYI: AXI = Advanced eXtensible Interface
>>        High-speed interconnect for chip cores ( provides higher
>> bursts/transfers than predecessor AHB = Advanced High-performance Bus
>> (AHB)).
>
> "If you check PATCH V2, we renamed this to (AMBA) AXI"
>

Geez, I totally missed Pavel was commenting on the first patch. Sorry,  
Rafa?.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
