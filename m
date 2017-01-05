From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 05 Jan 2017 10:41:16 +0100
Subject: [PATCH 1/8] ARM: dts: armada-370-rd: Utilize new DSA binding
In-Reply-To: <307da709-5dbd-845b-b7ec-d0c3d46ad2e6@gmail.com> (Florian
 Fainelli's message of "Wed, 4 Jan 2017 09:30:07 -0800")
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-2-f.fainelli@gmail.com>
 <20170103163609.GE32450@lunn.ch>
 <307da709-5dbd-845b-b7ec-d0c3d46ad2e6@gmail.com>
Message-ID: <87bmvletdv.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,
 
 On mer., janv. 04 2017, Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 01/03/2017 08:36 AM, Andrew Lunn wrote:
>>> +
>>> +	switch: switch at 10 {
>>> +		compatible = "marvell,mv88e6085";
>>> +		#address-cells = <1>;
>>> +		#size-cells = <0>;
>>> +		reg = <16>;
>> 
>> Hummm, a device tree question. switch at 10, reg = <16>. Is there an
>> implicit understanding that the 10 is hex?
>
> Most (if not all?) unit addresses are hexadecimal, which is why this was
> chosen here, but I really don't mind changing that.

And what about using:
		reg = <0x10>;

Gregory

> -- 
> Florian

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
