From: eric@anholt.net (Eric Anholt)
Date: Wed, 26 Apr 2017 10:25:40 -0700
Subject: [PATCH v2 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170426004907.GA9453@lunn.ch>
References: <20170425235357.7690-1-eric@anholt.net>
 <20170425235357.7690-2-eric@anholt.net> <20170426004907.GA9453@lunn.ch>
Message-ID: <87vaprjd2j.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

>> +		eth0: ethernet at 18042000 {
>> +			compatible = "brcm,amac";
>> +			reg = <0x18042000 0x1000>,
>> +			      <0x18110000 0x1000>;
>> +			reg-names = "amac_base", "idm_base";
>> +			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
>> +			max-speed = <1000>;
>
> Hi Eric
>
> Sorry i missed this the first time. Does this Ethernet controller do >
> 1Gbps? Does this max-speed do anything useful?

It doesn't look like it.  Dropped.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170426/66f27462/attachment.sig>
