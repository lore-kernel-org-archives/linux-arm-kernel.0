From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Thu, 9 Mar 2017 16:22:47 +0100
Subject: [arm] Lost support for Taskit Stamp9g20 AT91-based board
In-Reply-To: <2115594.QrpeoqLsjO@ada>
References: <alpine.LNX.2.20.1703072029140.7705@atlantide2>
 <2115594.QrpeoqLsjO@ada>
Message-ID: <51e538a6-0e81-0209-79a3-06da9cde843e@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 09/03/2017 ? 09:20, Alexander Dahl a ?crit :
> Hei hei,
> 
> Am Dienstag, 7. M?rz 2017, 20:35:43 schrieb Enrico Mioso:
>> I would like to add back the board .c file if possible: or try to
>> convert them to DT with some help.
> 
> I just had a quick view over the c file you attached. This looks like it 
> would be sufficient to create a proper dts file and activate the 
> necessary drivers in your kernel config.
> 
>> What's the best thing I can do to move on?
> 
> Have a look at the other dts files in arch/arm/boot/dts named at91-* ? I 
> could assemble a running dts file from that for a at91sam9g20 based 
> board few weeks ago.

Yes, DT is the only way forward.

>> Finds here the content of the .c file in question, that was part of
>> upstream at the time of 3.15. Don't know exactly when it got removed,
>> but it should be around that time frame.
> 
> AFAIK devicetree for at91 became mandatory with 3.19. Those board files 
> were still in kernel with 3.18 IIRC. Maybe ? 1 version.

Absolutely, here is the announcement sent back then:
"[ANNOUNCE] ARM: at91: removal of board files"
https://lkml.org/lkml/2014/9/10/293

And the actual pull-request that finished the work for 3.19:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309707.html

Best regards,
-- 
Nicolas Ferre
