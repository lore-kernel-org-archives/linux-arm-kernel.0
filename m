From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 9 Dec 2009 22:41:11 -0500
Subject: [PATCH v2 05/09] mfd: append subdev into 88pm860x driver
In-Reply-To: <771cded00912090514k74eee69du46060400e3610870@mail.gmail.com>
References: <771cded00912090514k74eee69du46060400e3610870@mail.gmail.com>
Message-ID: <771cded00912091941v4e404c67wadd3bcde3504cd38@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 8:14 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> From 75aba8cbe09fe8a224a96bc312554ff76fa4d745 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 9 Dec 2009 15:20:14 -0500
> Subject: [PATCH] mfd: append subdev into 88pm860x driver
>
> Append backlight, led & touch subdevs into 88pm860x driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> +
> +#define PM8606_LED_CURRENT(x) ? ? ? ? ?((x >> 2) & 0x07)
> +

Fix the definition issue.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0005-mfd-append-subdev-into-88pm860x-driver.patch
Type: text/x-patch
Size: 12963 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091209/7d68a804/attachment-0001.bin>
