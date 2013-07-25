From: jg1.han@samsung.com (Jingoo Han)
Date: Fri, 26 Jul 2013 08:52:09 +0900
Subject: [PATCHv2 3/3] fb: backlight: HX8357: Add HX8369 support
In-Reply-To: <1374757513-2253-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1374757513-2253-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374757513-2253-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <002301ce8991$f9b82060$ed286120$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 25, 2013 10:05 PM, Maxime Ripard wrote:
> 
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Add support for the Himax HX8369 controller as it is quite similar to the
> hx8357.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/backlight/hx8357.c | 221 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 206 insertions(+), 15 deletions(-)
> 

[....]

> +	ret = hx8357_spi_write_byte(lcdev, HX8357_SET_DISPLAY_ON);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(100);

Hi Maxime Ripard,

Could you add comment on this huge delay, too?

Best regards,
Jingoo Han
