From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 18 Nov 2014 00:23:53 +0100
Subject: [PATCHv1 2/3] arm: mvebu: add .dts file for Synology DS213j
In-Reply-To: <546A7997.1040603@killerwolves.net> (Ben Peddell's message of
 "Tue, 18 Nov 2014 08:41:27 +1000")
References: <cover.1416095841.git.arno@natisbad.org>
 <1eb26f8c1946622910a7e2318c895a7082fea7e5.1416095841.git.arno@natisbad.org>
 <20141116020024.GC15870@lunn.ch> <87d28nb83u.fsf@natisbad.org>
 <546931E1.5070909@killerwolves.net> <878ujas07o.fsf@natisbad.org>
 <546A7997.1040603@killerwolves.net>
Message-ID: <871tp1pg1i.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Ben Peddell <klightspeed@killerwolves.net> writes:

>>> The 5000RPM was interpolated from my measured RPM pulse rate (4200PPM)
>>> of the 80mm fan in my DS211j (which uses the 150-32-35 fan config) at
>>> maximum RPM.
>> 
>> Then, I think I need to change the speed map to have 1900 RPM as max
>> speed. Out of curiosity, how did you measured the RPM pulse rate
>> exactly?
>
> I hooked a logic analyzer to the sense pin and measured the pulse rate.
>
> Looking at the specifications of the fan in this unit (an EC7025L12ER),
> it has a maximum fan speed of 3000RPM, so it looks like it uses two
> pulses per revolution and not one as I had assumed when I created the
> speed map.

Thanks for this feedback.

Cheers,

a+
