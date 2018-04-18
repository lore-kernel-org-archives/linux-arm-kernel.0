From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 18 Apr 2018 17:47:59 +0200
Subject: [PATCH v2 2/2] pinctrl/samsung: Document required order of banks
In-Reply-To: <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
References: <1523893966-8884-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1523893966-8884-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CA+Ln22Hgn5VmeUAdcmHi64-HdRqpuGBBN9uUzmFTOBatagzXeg@mail.gmail.com>
Message-ID: <CAJKOXPc_0RenBVA+wDshqD3Q0S3kCu_60v_V5XMCvtWeOv+Hrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 4:14 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2018-04-17 0:52 GMT+09:00 Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>:
>> This patch documents requirement coming from the way
>> exynos_eint_gpio_irq() is working now, which expects
>> EINTG banks to be at the beginning of the bank arrays.
>>
>> Cc: stable at vger.kernel.org
>
> Probably no need for this one to go to stable, but either is fine for me.
>
>> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
>> ---
>>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c   | 26 ++++++++++++++++++++++++++
>>  drivers/pinctrl/samsung/pinctrl-exynos-arm64.c | 20 ++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks, applied without cc-stable.

Best regards,
Krzysztof
