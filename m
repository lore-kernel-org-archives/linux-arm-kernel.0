From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 01:07:50 +0200
Subject: [PATCH v2] gpio: samsung: add devicetree init for s3c24xx arches
In-Reply-To: <503D4FB1.1020206@samsung.com>
References: <201208282355.44268.heiko@sntech.de> <503D4FB1.1020206@samsung.com>
Message-ID: <CACRpkdYqYhtHHVw8C5HhDr96V6diV-0M+55xCHnoATOiyDp3Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 1:09 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 08/28/12 14:55, Heiko St?bner wrote:
>>
>> Until now the Exynos-SoC was the only Samsung-SoC supporting the GPIOs
>> via the device tree. This patch implements dt-support for the
>> s3c24xx arches.
>>
>> The controllers contain only 3 cells, as the underlying gpio controller
>> does not support controlling the drive strength on a gpio level.
>>
>> Tested with the gpio-keys driver on a s3c2416 based machine.
>>
>> Signed-off-by: Heiko Stuebner<heiko@sntech.de>
>> Reviewed-by: Thomas Abraham<thomas.abraham@linaro.org>
>
>
> Yeah, looks good to me...
>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

OK are you taking this into the Samsung tree or shall I take care of it?

Yours,
Linus Walleij
