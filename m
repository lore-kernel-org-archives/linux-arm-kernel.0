From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 23:37:23 +0100
Subject: [PATCH 3/4] ASoC: pxa: add binding for pxa2xx-ac97 audio complex
In-Reply-To: <20160223191934.GA29262@rob-hp-laptop> (Rob Herring's message of
 "Tue, 23 Feb 2016 13:19:34 -0600")
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <1455979079-9030-3-git-send-email-robert.jarzmik@free.fr>
 <20160223191934.GA29262@rob-hp-laptop>
Message-ID: <87wpprt7x8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

>> +Example:
>> +	ac97: sound at 40500000 {
>> +	      	compatible = "marvell,pxa2xx-ac97";
>> +		reg = < 0x40500000 0x1000 >;
>> +		interrupts = <14>;
>> +		reset-gpio = <&gpio 113 GPIO_ACTIVE_HIGH>;
>> +		#sound-dai-cells = <1>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = < &pmux_ac97_default >;
>> +		status = "okay";
>
> No clocks prop, yet required.
Ah yeah, that's a good catch, thanks.

I'll resubmit once my discussion with Mark on ac97 will be finished, which might
takes monthes given all I have to do lately.

Cheers.

-- 
Robert
