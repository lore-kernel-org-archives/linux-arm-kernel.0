From: cooloney@gmail.com (Bryan Wu)
Date: Wed, 20 Mar 2013 17:23:43 -0700
Subject: [PATCH 0/4] led: drivers bug fixes
In-Reply-To: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
References: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <CAK5ve-+Qbqjd47JqEtdMNxjVfUeFbq3ANGzT6zdXXheyTOD_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 19, 2013 at 11:07 AM, Simon Guinot
<simon.guinot@sequanux.org> wrote:
> Here are some bug fixes for the LED drivers leds-ns2, leds-lt3593 and
> leds-renesas-tpu. Note that I don't have tested the patches related with
> the two lasts. I don't have the hardware.
>
> Regards,
>
> Simon
>
> Simon Guinot (4):
>   leds: leds-ns2: fix oops at module removal

Thanks, I merged this patch and other 3 patches are already in my git tree.

-Bryan

>   leds: leds-ns2: fix devm_gpio_request_one() flags parameter
>   leds: leds-lt3593: fix devm_gpio_request_one() flags parameter
>   leds: renesas: fix devm_gpio_request_one() flags parameter
>
>  drivers/leds/leds-lt3593.c      |    5 +++--
>  drivers/leds/leds-ns2.c         |   44 ++++++++++++++++++++++++++-------------
>  drivers/leds/leds-renesas-tpu.c |    3 ++-
>  3 files changed, 34 insertions(+), 18 deletions(-)
>
> --
> 1.7.10.4
>
