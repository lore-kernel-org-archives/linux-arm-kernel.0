From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 14:23:46 +0200
Subject: [PATCH 3/3] ARM64: dts: amlogic: Enable Reset Controller on
 GXBB-based platforms
In-Reply-To: <20160520122245.GA22047@mephisto>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-4-git-send-email-narmstrong@baylibre.com>
 <20160520084748.GC16732@mephisto> <573ED06F.9070909@baylibre.com>
 <20160520091050.GC19888@mephisto> <573F00CD.8070504@baylibre.com>
 <20160520122245.GA22047@mephisto>
Message-ID: <573F01D2.1090602@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2016 02:22 PM, Carlo Caione wrote:
> On 20/05/16 14:19, Neil Armstrong wrote:
> 
> [...]
>>>>> Missing #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h> ?
>>>>>
>>>>> Thanks,
>>>>>
>>>>
>>>> Shouldn't we wait until the reset bindings are actually used in the dtsi ?
>>>> I'm quite sure kevin will post it with the Ethernet nodes.
>>>
>>> Why? The header file is related to the reset controller. Better add it
>>> now with this patchset.
>>>
>>> Cheers,
>>>
>>
>> OK, I will add it in gxbb and meson8b dtsi files.
> 
> Why also meson8b DTSI?
> 

Sorry, I'll add the meson8b specific header of course.

Neil
