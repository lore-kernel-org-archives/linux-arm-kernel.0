From: bernhard.nortmann@web.de (Bernhard Nortmann)
Date: Mon, 30 May 2016 22:26:21 +0200
Subject: [linux-sunxi] Re: [PATCH] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <20160530194340.GE4908@lukather>
References: <20160530123013.11575-1-luoyi.ly@gmail.com>
 <20160530194340.GE4908@lukather>
Message-ID: <574CA1ED.8050007@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.05.2016 um 21:43 schrieb Maxime Ripard:
> Hi,
>
> On Mon, May 30, 2016 at 08:30:13PM +0800, luoyi.ly at gmail.com wrote:
>> From: luoyi <luoyi.ly@gmail.com>
>>
>> Add support for the Bananapi M1 Plus A20 development board from sinovoip.com.cn .
>> This board features 1G RAM, 2 USB A receptacles, 1 micro USB receptacle for
>> OTG, 1 micro USB receptacle for power, HDMI, sata, Gbit ethernet, ir receiver,
>> 3.5 mm jack for stero sound out, on board microphone, 40 gpio pins and sdio wifi.
> What is the difference between the M1+ and the M1?

The M1+ is an updated version of the original Banana Pi. If you're 
interested
in the details, have a look at http://linux-sunxi.org/Banana_Pi#Variants .
"BPi-M1+" is SinoVoip's counterpart of LeMaker's "Banana Pro", for which 
a .dts
already exists. Judging from .fex files, only a single pin assignment 
seems to
differ between the two (audio_pa_ctrl, PH26 vs. PH15).

Regards, B. Nortmann
