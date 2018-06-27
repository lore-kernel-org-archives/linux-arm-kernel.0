From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 27 Jun 2018 17:28:04 +0200
Subject: [PATCH v3 2/2] ARM: dts: pxa: fix the rtc controller
In-Reply-To: <20180627171627.592849b5@windsurf.home> (Thomas Petazzoni's
 message of "Wed, 27 Jun 2018 17:16:27 +0200")
References: <20180627150150.23951-1-robert.jarzmik@free.fr>
 <20180627150150.23951-2-robert.jarzmik@free.fr>
 <20180627171627.592849b5@windsurf.home>
Message-ID: <87muvgl057.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Petazzoni <thomas.petazzoni@bootlin.com> writes:

> Hello,
>> +		rtc at 40900000 {
>> +			clocks = <&clks CLK_OSC32k768>>;
>
> Double closing bracket, doesn't look good.

Rrrr you're right ... I swear this patchset is cursed ...

Thanks for spotting that, I'll send a v4.

Cheers.

-- 
Robert
