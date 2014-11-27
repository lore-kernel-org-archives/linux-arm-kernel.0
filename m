From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 27 Nov 2014 16:12:58 +0900
Subject: [PATCH v3] gpio: mxs: implement get_direction callback
In-Reply-To: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1416387322-17320-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <CAAVeFuK6Xq-fansQfP_Wknkfw9O84=iCaQyK=i=WXoM50By+yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 5:55 PM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
> gpiolib's gpiod_get_direction() function returns the EINVAL error
> if .get_direction callback is not defined.
> The patch implements the callback for mxs chip which is useful
> for debugging.
>
> Inspired by arch/arm/mach-at91/gpio.c
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
