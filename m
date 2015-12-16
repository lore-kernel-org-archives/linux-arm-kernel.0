From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 16 Dec 2015 12:55:34 +0100
Subject: [PATCH v2] soc: mediatek: SCPSYS: use module_platform_driver
In-Reply-To: <1562792.sV6cmsyeOM@wuerfel>
References: <1450263656-12513-1-git-send-email-s.hauer@pengutronix.de>
 <1562792.sV6cmsyeOM@wuerfel>
Message-ID: <56715136.3060908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/12/15 12:22, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 12:00:56 Sascha Hauer wrote:
>> With regulator support to the scpsys driver needs to be able to defer
>> probe. Probe deferral is incompatible with module_platform_driver_probe,
>> so use module_platform_driver. module_platform_driver_probe sets the
>> suppress_bind_attrs. To prevent unbinding the device with
>> module_platform_driver we have to set the flag explicitly in the driver
>> now.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>
>
> Looks good now,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>

Applied to v4.4-next/soc

Sascha next time please don't forget to send Mediatek related patches to 
the corresponding mailinglist as well.

Thanks,
Matthias
