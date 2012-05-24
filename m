From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 24 May 2012 14:34:31 +0530
Subject: [PATCH 2/6] ARM: Exynos5: Add spi clock support
In-Reply-To: <006b01cd397f$09784840$1c68d8c0$%kim@samsung.com>
References: <1337334392-6441-1-git-send-email-thomas.abraham@linaro.org>
 <1337334392-6441-3-git-send-email-thomas.abraham@linaro.org>
 <006b01cd397f$09784840$1c68d8c0$%kim@samsung.com>
Message-ID: <CAJuYYwRThKda0E7ruDbW=X5_6RVran6NA+rBRdRNG1A=-Uny3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2012 13:00, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Thomas Abraham wrote:
>>
>> Add support for clock instances for each spi controller.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
>> ---
>>
>> +static struct clksrc_clk exynos5_clk_mdout_spi0 = {
>
> See the previous comments and below url.
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-February/083153.h
> tml

Exynos5 is only device tree based now. And there are changes in the
platform data also now.

Thanks,
Thomas.

>
> [...]
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
