From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 16:57:18 +0100
Subject: [PATCH 5/5] ARM: dts: exynos5250-snow: Enable wifi power-on
In-Reply-To: <54C8EC38.6010702@broadcom.com>
References: <1422439819-29854-1-git-send-email-javier.martinez@collabora.co.uk>
 <1422439819-29854-6-git-send-email-javier.martinez@collabora.co.uk>
 <54C8EC38.6010702@broadcom.com>
Message-ID: <54C906DE.9070308@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arend,

Thanks for your feedback.

On 01/28/2015 03:03 PM, Arend van Spriel wrote:
> On 01/28/15 11:10, Javier Martinez Canillas wrote:

>>   &dp {
>> @@ -531,17 +538,33 @@
>>   	status = "okay";
>>   	num-slots =<1>;
>>   	broken-cd;
>> +	cap-sdio-irq;
> 
> This seems like an unrelated change, right?
> 

Well, I found that enabling the SDIO IRQ signalling I had the double
of the transfer rate and I didn't think it justified a separate patch
but you are right and I'll split on v2.

> Regards,
> Arend
> 

Best regards,
Javier
