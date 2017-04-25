From: eric@anholt.net (Eric Anholt)
Date: Mon, 24 Apr 2017 17:00:31 -0700
Subject: [PATCH 2/2] ARM: dts: Add the ethernet and ethernet PHY to the
 cygnus core DT.
In-Reply-To: <20170424220842.GA26241@lunn.ch>
References: <20170424215022.30382-1-eric@anholt.net>
 <20170424215022.30382-3-eric@anholt.net> <20170424220842.GA26241@lunn.ch>
Message-ID: <8737cxe4ps.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew Lunn <andrew@lunn.ch> writes:

>> +		mdio: mdio at 18002000 {
>> +			compatible = "brcm,iproc-mdio";
>> +			reg = <0x18002000 0x8>;
>> +			#size-cells = <1>;
>> +			#address-cells = <0>;
>> +
>> +			gphy0: eth-gphy at 0 {
>> +				reg = <0>;
>> +				max-speed = <1000>;
>> +			};
>> +
>> +			gphy1: eth-gphy at 1 {
>> +				reg = <1>;
>> +				max-speed = <1000>;
>> +			};
>> +		};
>
> Hi Eric
>
> Do these max-speed properties do anything useful? Is the PHY capable
> of > 1Gbps?

Not sure where I had those copy-and-pasted from, but they don't seem
necessary.  Dropped.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/ee121fb9/attachment.sig>
