From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 23 Jul 2017 23:02:53 +0200 (CEST)
Subject: No Ethernet on Raspberry Pi 3 in v4.13-rc1
In-Reply-To: <dff231c6-feb4-fc15-75e9-cc5696ad2e55@suse.de>
References: <5650979e-ea55-0337-2edd-d2c3e8ad0e37@suse.de>
 <634582831.41619.1500728895557@email.1und1.de>
 <dff231c6-feb4-fc15-75e9-cc5696ad2e55@suse.de>
Message-ID: <1115544947.95458.1500843773126@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Andreas F?rber <afaerber@suse.de> hat am 22. Juli 2017 um 15:33 geschrieben:
> 
> 
> Hi Stefan,
> 
> Am 22.07.2017 um 15:08 schrieb Stefan Wahren:
> > Andreas F?rber <afaerber@suse.de> hat am 22. Juli 2017 um 14:29 geschrieben:
> >> With arm64 4.13-rc1 I get no eth0 device on Pi3 (openSUSE Tumbleweed).
> >> The v4.13-rc1 DT works okay with a 4.12 kernel.
> > 
> > do you use arm64/defconfig or a modified one?
> 
> I had updated our custom config via oldconfig, the result is here:
> 
> https://kernel.opensuse.org/cgit/kernel-source/plain/config/arm64/default

There seems to be multiple issues. Using the arm64/defconfig USB seems to completly broken (4.10, 4.11, 4.12).

Since i don't know the reason, i would start bisecting based on the custom config.

> 
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
