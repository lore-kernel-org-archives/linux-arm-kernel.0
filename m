From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 22 Jul 2017 15:33:57 +0200
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <634582831.41619.1500728895557@email.1und1.de>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <634582831.41619.1500728895557@email.1und1.de>
Message-ID: <dff231c6-feb4-fc15-75e9-cc5696ad2e55@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am 22.07.2017 um 15:08 schrieb Stefan Wahren:
> Andreas F?rber <afaerber@suse.de> hat am 22. Juli 2017 um 14:29 geschrieben:
>> With arm64 4.13-rc1 I get no eth0 device on Pi3 (openSUSE Tumbleweed).
>> The v4.13-rc1 DT works okay with a 4.12 kernel.
> 
> do you use arm64/defconfig or a modified one?

I had updated our custom config via oldconfig, the result is here:

https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
