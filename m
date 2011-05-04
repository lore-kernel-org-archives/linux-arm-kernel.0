From: camhirundo@gmail.com (Hirundo Cam)
Date: Wed, 4 May 2011 15:56:49 +0800
Subject: [PATCH v2] kirkwood: add dir-665 support
In-Reply-To: <1304496346-13557-1-git-send-email-camhirundo@gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<1304496346-13557-1-git-send-email-camhirundo@gmail.com>
Message-ID: <BANLkTikCOm8t-BoSdB0+bqpUjgeOX3obsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

2011/5/4 Hirundo Cam <camhirundo@gmail.com>:
> This patch is a hack to dir-665 by referencing mv88f6281gtw_ge board.
> LEDs, GPIO, Buttons remains unknown.
>
> To use this patch, on board u-boot must also be recompiled and replaced.
>
> Signed-off-by: Hirundo Cam <camhirundo@gmail.com>
> ---
> Changes for V2
> ?- Remove mach-type and register a new machine to
> ? ?http://www.arm.linux.org.uk/developer/machines/
> ?- Replace mv88f6281_dir665 to dir665 according to Simon's suggestion.
> ?- Rename mv88f6281_dir665.c to dir665-setup.c
> ?- Remove include/leds.h, gpio.h, input.h, gpiokey.h according to Mike's
> ? ?suggestion.

Sorry for the duplicate mail. The latter one is the same as the older one.
Only the [PATCH v2] and [PATCH] field in subject is different.
Thanks!

Regards,
Hirundo Cam
