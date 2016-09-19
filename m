From: ppajuel@gmail.com (Pau Pajuel)
Date: Mon, 19 Sep 2016 10:13:15 +0200
Subject: [PATCH] ARM: dts: Add power button support for igepv5
In-Reply-To: <31409234-3185-5348-2d37-effb7769c92a@osg.samsung.com>
References: <20160909210729.20184-1-tony@atomide.com>
 <31409234-3185-5348-2d37-effb7769c92a@osg.samsung.com>
Message-ID: <CAMVEqEkKrw2eH3L6+te5MZLqxBT2jUiRO-KNuS+9nuNYvihCRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tony,

2016-09-14 3:26 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> Hello Tony,
>
> On 09/09/2016 05:07 PM, Tony Lindgren wrote:
>> Add power button support for igepv5.
>>
>> Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
>> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>> Cc: Pau Pajuel <ppajuel@gmail.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>
> I don't have a schematics for this board, but the patch looks good to me.
Patch has an errata. Power button is GPIO_ACTIVE_LOW instead GPIO_ACTIVE_HIGH.
>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
Best regards
