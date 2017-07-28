From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Fri, 28 Jul 2017 10:14:06 +0200
Subject: [PATCH 0/4] iio: trigger: stm32-timer fixes
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <CA+M3ks5c98rc2RavW5Eon+MXqnMEpSxcFDaQeL=t4rGbjhR3Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-07-27 18:18 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> Miscellaneous fixes for stm32-timer-trigger driver.
> Last patch adds enable attribute, which unlocks use of
> encoder mode.
>
> Fabrice Gasnier (4):
>   iio: trigger: stm32-timer: fix quadrature mode get routine
>   iio: trigger: stm32-timer: fix write_raw return value
>   iio: trigger: stm32-timer: fix get/set down count direction
>   iio: trigger: stm32-timer: add enable attribute
>

For the series:

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>  drivers/iio/trigger/stm32-timer-trigger.c | 80 ++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 22 deletions(-)
>
> --
> 1.9.1
>



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
