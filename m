From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 2 Jan 2015 11:16:10 +0100
Subject: [PATCH v8 3/4] ARM: mediatek: Add sysirq in mt6589/mt8135/mt8127
 dtsi
In-Reply-To: <1419473469.7238.0.camel@mtksdaap41>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416902662-19281-4-git-send-email-yingjoe.chen@mediatek.com>
 <1419473469.7238.0.camel@mtksdaap41>
Message-ID: <CABuKBeKj_+-7r-bUe_vuDdyE2V-uugfZ03dMwcbaqnNz8fLEXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

2014-12-25 3:11 GMT+01:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
>
> Hi Matthias,
>
> On Tue, 2014-11-25 at 16:04 +0800, Yingjoe Chen wrote:
>> Add sysirq settings for mt6589/mt8135/mt8127
>> This also correct timer interrupt flag. The old setting works
>> because boot loader already set polarity for timer interrupt.
>> Without intpol support, the setting was not changed so gic
>> can get the irq correctly.
>>
>> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
>> ---
>>  arch/arm/boot/dts/mt6589.dtsi | 14 ++++++++++++--
>>  arch/arm/boot/dts/mt8127.dtsi | 14 ++++++++++++--
>>  arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++--
>>  3 files changed, 36 insertions(+), 6 deletions(-)
>
> It seems this patch is not merged in 3.19-rc1. This do have dependency
> on other patches, and all the other patches in this series are merged.
>
> Is this planed to merge later or do we need to send additional pull
> request for it?

This patch got somehow lost, sorry for that. I apply it for v3.20.

>
> Joe.C
>
>



-- 
motzblog.wordpress.com
