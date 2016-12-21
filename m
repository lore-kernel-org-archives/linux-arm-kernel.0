From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 21 Dec 2016 09:57:55 +0100
Subject: [PATCH v2 3/3] arm64: dts: marvell: Add ethernet switch
 definition for the ESPRESSObin
In-Reply-To: <20161220161714.GD30952@lunn.ch>
References: <20161220085138.3998-1-romain.perier@free-electrons.com>
 <20161220085138.3998-4-romain.perier@free-electrons.com>
 <20161220154234.GC30952@lunn.ch>
 <c27998fd-3807-5c99-382b-b8d0d0f06526@free-electrons.com>
 <20161220161714.GD30952@lunn.ch>
Message-ID: <28dca2e8-64e2-a39b-600c-0530f03d988f@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 20/12/2016 ? 17:17, Andrew Lunn a ?crit :
>>>> +		mdio {
>>>> +			#address-cells = <1>;
>>>> +			#size-cells = <0>;
>>>> +			reg = <1>;
>>>
>>> what is this reg value for?
>>>
>>>     Andrew
>>>
>>
>> It was required to avoid a warning thrown by the mdio subsystem
>
> Do you remember what the warning was?
>
> This seems odd to me. I don't see why a reg is needed here.
>
> Thanks
> 	Andrew
>

Mhhh, in fact, I did changes to this mdio node, I relocated it...
the warning was probably before the relocation, because I no longer see 
it. So I have removed this reg value.

Thanks,
Romain
