From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 22 Jun 2010 09:18:35 +0900
Subject: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
In-Reply-To: <AANLkTimhik3BOQNzybs1tUuHUXri-yxm5v7wH1JjQ5B1@mail.gmail.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
	<AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
	<4C1F4B30.3020006@samsung.com>
	<AANLkTimhik3BOQNzybs1tUuHUXri-yxm5v7wH1JjQ5B1@mail.gmail.com>
Message-ID: <00fb01cb11a0$76cfa3b0$646eeb10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric Miao wrote:
> 
> >> and now in s5pc200 code, you can also register/re-use the s5pc100_keypad
> >> device/driver, and everyone knows - OK, the IP on S5PC100 is now re-used
> >> here.
> >>
> >
> > This is naming issue and i know it was not desided yet.
> > This keypad driver can support s3c64xx, s5pc100, s5pc110, s5pv210.
> >
> 
> I bet the first silicon this IP is deployed is s3c64xx, so my understanding
> 's3c64xx-keypad.c' should be an acceptable name.  And it's also reasonable,
> a s3c64xx-keypad driver, and is later expanded to support subsequent silicons
> without the file name being changed.

Hi,

Seems to be more suitable 'samsung-keypad', because can support S5PC100, S5PC110, and S5PV210 as well as S3C64XX.
Already tested on SMDK6410(S3C6410), SMDKC100(S5PC100), Aquila(S5PC110), GONI(S5PC110) and SMDKV210(S5PV210) boards.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
