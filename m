From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 20 Aug 2014 12:36:11 +0200
Subject: [PATCH 5/6] ARM: dts: Add vmmc and vqmmc supplies for Peach Pit
 and Pi boards
In-Reply-To: <53F476C6.9030809@collabora.co.uk>
References: <1408460913-13863-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408460913-13863-6-git-send-email-javier.martinez@collabora.co.uk>
 <53F39978.3080901@suse.de> <53F476C6.9030809@collabora.co.uk>
Message-ID: <53F47A1B.2030204@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On 08/20/2014 12:21 PM, Javier Martinez Canillas wrote:
> Hello Andreas,
> 
> Thanks a lot for your feedback.
> 
> On 08/19/2014 08:37 PM, Andreas F?rber wrote:
>>>  &mmc_2 {
>>> +	vmmc-supply = <&tps65090_fet4>;
>>> +	vqmmc-supply = <&vqmmc_sdcard>;
>>>  	status = "okay";
>>>  	num-slots = <1>;
>>>  	supports-highspeed;
>> 
>> A convention that I picked up was to place overridden status property
>> first. Do your new properties really need to go before that?
>>
> 
> OF doesn't care about the order of the child nodes but I do agree that
> consistency is a good thing so I'll change that on v2.
> 

Actually I meant that I'll change this for a future re-post since I'm
completely dropping this patch from the series due Doug's explanation
about the CD line and VCCQ/VDD_IO being in the same power rail on Exynos5
SoCs.

Sorry for the noise...

Best regards,
Javier
