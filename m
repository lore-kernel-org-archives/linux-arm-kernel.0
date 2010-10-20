From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 20 Oct 2010 18:10:02 +0900
Subject: [PATCH 3/4] ARM: S5PV210: I2S: Upgrade platform device
In-Reply-To: <05c801cb702c$68de4460$3a9acd20$%kim@samsung.com>
References: <1287472511-529-1-git-send-email-jassisinghbrar@gmail.com>
	<05c801cb702c$68de4460$3a9acd20$%kim@samsung.com>
Message-ID: <AANLkTinm=+42bvBKdh6ssiURpTAqSLEOeWrJiL-tL+eR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 4:57 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:

>> ? ? ? switch (pdev->id) {
>> + ? ? case 0:
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(0), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(1), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(2), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(3), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(4), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(5), S3C_GPIO_SFN(2));
>> + ? ? ? ? ? ? s3c_gpio_cfgpin(S5PV210_GPI(6), S3C_GPIO_SFN(2));
>
> s3c_gpio_cfgpin_range(S5PV210_GPI(0), 7, S3C_GPIO_SFN(2))?

OK



> Hmm...
> It would be helpful to me if you could make your patch which is regarding
> arch/arm/ against on my for-next.

Will do.

Thanks.
