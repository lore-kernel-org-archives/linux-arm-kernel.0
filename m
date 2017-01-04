From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 4 Jan 2017 09:30:07 -0800
Subject: [PATCH 1/8] ARM: dts: armada-370-rd: Utilize new DSA binding
In-Reply-To: <20170103163609.GE32450@lunn.ch>
References: <20170102022249.10657-1-f.fainelli@gmail.com>
 <20170102022249.10657-2-f.fainelli@gmail.com>
 <20170103163609.GE32450@lunn.ch>
Message-ID: <307da709-5dbd-845b-b7ec-d0c3d46ad2e6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/2017 08:36 AM, Andrew Lunn wrote:
>> +
>> +	switch: switch at 10 {
>> +		compatible = "marvell,mv88e6085";
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		reg = <16>;
> 
> Hummm, a device tree question. switch at 10, reg = <16>. Is there an
> implicit understanding that the 10 is hex?

Most (if not all?) unit addresses are hexadecimal, which is why this was
chosen here, but I really don't mind changing that.
-- 
Florian
