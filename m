From: tobiasrauter@gmail.com (Tobias Rauter)
Date: Thu, 01 Aug 2013 09:40:48 +0200
Subject: [PATCH 1/10] ARM: dts: mxs: move 'compatible' property to
 beginning of node and do some whitespace cleanups
In-Reply-To: <20985.63716.320416.93668@ipc1.ka-ro>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
 <51F971B4.1050605@cogentembedded.com> <20985.63716.320416.93668@ipc1.ka-ro>
Message-ID: <51FA1100.2040303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.08.2013 07:57, Lothar Wa?mann wrote:
> Hi,
>
> Sergei Shtylyov writes:
>> Hello.
>>
>> On 07/31/2013 06:37 PM, Lothar Wa?mann wrote:
>>> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
>>> index 47fc5ef..0360acc 100644
>>> --- a/arch/arm/boot/dts/imx28.dtsi
>>> +++ b/arch/arm/boot/dts/imx28.dtsi
>>> @@ -731,9 +731,9 @@
>>>    			};
>>>
>>>    			dcp at 80028000 {
>>> +				compatible = "fsl-dcp";
>>      Hm, why not the usual "fsl,dcp", where "fsl" is Freescale's stock ticker?
>>
> Don't ask me, but the author of the patch that introduced this
> (CC'ed), or the maintainer who accepted this in the first place.

Hi!

The simple reason is that I didn't know it better when I wrote this.
I think I can send a patch until Monday.
But feel free to change it yourself if you want.

Tobias
