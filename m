From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 21 Jun 2010 22:19:55 +0800
Subject: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <4C1F4B30.3020006@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<4C1F4B30.3020006@samsung.com>
Message-ID: <AANLkTimhik3BOQNzybs1tUuHUXri-yxm5v7wH1JjQ5B1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> and now in s5pc200 code, you can also register/re-use the s5pc100_keypad
>> device/driver, and everyone knows - OK, the IP on S5PC100 is now re-used
>> here.
>>
>
> This is naming issue and i know it was not desided yet.
> This keypad driver can support s3c64xx, s5pc100, s5pc110, s5pv210.
>

I bet the first silicon this IP is deployed is s3c64xx, so my understanding
's3c64xx-keypad.c' should be an acceptable name.  And it's also reasonable,
a s3c64xx-keypad driver, and is later expanded to support subsequent silicons
without the file name being changed.
