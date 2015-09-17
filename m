From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 17 Sep 2015 22:20:56 +0800
Subject: [linux-sunxi] Re: [PATCH 2/4] ARM: dts: sun7i: Add keypad node to
 Allwinner A20 SoC
In-Reply-To: <20150917112905.GC4684@lukather>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-3-git-send-email-yassinjaffer@gmail.com>
 <20150917112905.GC4684@lukather>
Message-ID: <CAGb2v65oi9bbMMnY8GnokUk_ufty_y-+g99gYBy+Q40gt3d2Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 7:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Yassin,
>
> On Wed, Sep 16, 2015 at 12:05:55AM +1000, yassinjaffer at gmail.com wrote:
>> From: Yassin Jaffer <yassinjaffer@gmail.com>
>>
>> Add Keypad controller node definition to the A20 SoC.
>>
>> Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
>> index 333604a..35cc8d0 100644
>> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
>> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
>> @@ -1198,6 +1198,15 @@
>>                       status = "disabled";
>>               };
>>
>> +             kp: kp at 01c23000 {
>
> The node name should reflect the class of the device. keypad at 01c23000
> would be better for example.

Expanding the label to "keypad" as well would be nice.
"kp" could mean other things.

Thanks.

ChenYu

> It looks good otherwise.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
