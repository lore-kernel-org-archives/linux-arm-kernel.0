From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 28 Jan 2015 13:47:28 +0100
Subject: [PATCH V4 1/4] mmc: core: Initial support for MMC power sequences
In-Reply-To: <CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
 <1421658784-11980-2-git-send-email-ulf.hansson@linaro.org>
 <CABxcv==xBNsh+NrVb8PcBVtxQOKDL79YMkwK=wOL0gJZriEUjw@mail.gmail.com>
 <CAPDyKFoze-26fPm+C=D_o3tMSXWeTV4=2ZfOKaC3uLtxCrtjvg@mail.gmail.com>
Message-ID: <CABxcv==6AtUxbaXSmYm3fx4961x_UsN_oCLmWbTY9EZR_iZN9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ulf,

On Wed, Jan 28, 2015 at 12:36 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> ---
>>
>> Patch looks good to me and I could successfully get the SDIO wlan chip
>> in the Snow Chromebook after extending the pwrseq_simple driver so on
>> Exynos5250 Snow Chromebook:
>
> By extending you mean?
>

Sorry, I shoud had mentioned it. I meant the "Add multiple GPIO and
external clock to MMC pwrseq_simple" series [0] I posted before.

>>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
>> Best regards,
>> Javier
>
> Thanks for testing and reviewing! I have applied your tags to the patches.
>

You are welcome, thanks a lot for working on this.

Best regards,
Javier

[0]: http://www.spinics.net/lists/arm-kernel/msg395445.html
