From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 03:29:48 +0200
Subject: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
In-Reply-To: <1318178172-7965-5-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-5-git-send-email-zoss@devai.org>
Message-ID: <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
> ?arch/arm/mach-spmp8000/adc.c ? ? ? ? ? ? ? ? ? ? ?| ?465 +++++++++++++++++++++
> ?arch/arm/mach-spmp8000/include/mach/spmp8000adc.h | ? 29 ++

I think we stopped stuffing misc drivers under arch/arm/*

And stuffing them under drivers/misc/* won't be popular either.

IIO has some ADCs in drivers/staging/iio/adc
these seem all to be intended to be used from userspace.

There are a few in-kernel ADCs all over the kernel tree
for various specific purposes.

I don't know where we should go with this kind of stuff,
really :-/

Yours,
Linus Walleij
