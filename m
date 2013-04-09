From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 9 Apr 2013 11:37:01 +0530
Subject: [PATCH v3] mmc: dw_mmc: let device core setup the default pin
 configuration
In-Reply-To: <003501ce3453$502adf80$f0809e80$%jun@samsung.com>
References: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
 <003501ce3453$502adf80$f0809e80$%jun@samsung.com>
Message-ID: <CAJuYYwQmK=Lxw_+3GDHw=_c=3UJJNi0rcNjxNKPtDMPMw29YoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 April 2013 17:49, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> On Friday, April 05, 2013, Thomas Abraham wrote:
>> With device core now able to setup the default pin configuration,
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> I hope that your another patch is merged.
>  ARM: dts: add pinctrl nodes for Exynos5250 SoC
> I didn't check whether it is applied.

Hi Seungwon,

Thanks for your Ack. Yes, the pinctrl nodes for Exynos5250 have been
merged through kgene's tree.

Regards,
Thomas.

>
> Thanks,
> Seungwon Jeon
>
