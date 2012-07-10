From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 15:24:32 +0800
Subject: [PATCH v2 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <201207100920.03867.marex@denx.de>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
 <1341898587-8462-4-git-send-email-shawn.guo@linaro.org>
 <201207100920.03867.marex@denx.de>
Message-ID: <CAAQ0ZWQg8qX_hySRSfADKgtR1DB5z8+X+kkAQi_dNOEROqX0Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2012 15:20, Marek Vasut <marex@denx.de> wrote:
> Dear Shawn Guo,
>
>> From: Marek Vasut <marex@denx.de>
>>
> [...]
>
>> +     sound {
>> +             compatible = "fsl,imx28-evk-sgtl5000",
>
> imx28-evk ? ;-)
>
Will fix it, as well as apx4devkit.dts.

>> +                          "fsl,mxs-audio-sgtl5000";
>> +             model = "imx28-evk-sgtl5000";
>> +             saif-controllers = <&saif0 &saif1>;
>> +             audio-codec = <&sgtl5000>;
>> +     };
>> +};
>
> Otherwise, add my Acked-by: Marek Vasut <marex@denx.de> so if it gets broken
> now, the blame falls on my head ;-)
>
I'm much relieved now.

Regards,
Shawn
