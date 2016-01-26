From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 26 Jan 2016 17:31:50 +0300
Subject: [PATCH] ARM: dts: porter: add sound support
In-Reply-To: <87k2mya48g.wl%kuninori.morimoto.gx@renesas.com>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <1872468.4EonQLNEFn@wasted.cogentembedded.com>
 <87k2mya48g.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <56A78356.4030407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/25/2016 03:35 AM, Kuninori Morimoto wrote:

>> Define the Porter board dependent part of the R8A7791 sound device node.
>> Add device node for Asahi Kasei AK4642 stereo codec  to the I2C2 bus.
>> Add the "simple-audio-card" device node to interconnect the SoC sound
>> device  and the codec.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

    Thank you. I forgot to mention that the patch was based on your work... :-/

>> +/*
>> + * SSI-AK4642
>> + *
>> + * SW3: 1: AK4642
>> + *      3: ADV7511
>
> This is no a big deal, but according to my schematic,
> porter is using JP3, not SW3, but no one cares ;P

    Indeed, sorry about that.

> Best regards
> ---
> Kuninori Morimoto

MBR, Sergei
