From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 22 Feb 2014 10:57:01 +0900
Subject: [PATCH] gpio: msm: switch Kconfig to ARCH_QCOM depends
In-Reply-To: <E44A8A90-550C-438C-9EA0-61E033BB988E@codeaurora.org>
References: <1392150132-21877-1-git-send-email-galak@codeaurora.org>
 <E44A8A90-550C-438C-9EA0-61E033BB988E@codeaurora.org>
Message-ID: <CAAVeFuLDAhrS+ntNhOoszRXSrBLFaEhVTKkYbRtiAfogbjbexQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 12:33 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Feb 11, 2014, at 2:22 PM, Kumar Gala <galak@codeaurora.org> wrote:
>
>> We've split Qualcomm MSM support into legacy and multiplatform.  The gpio
>> msm-v2 driver is only relevant on the multiplatform supported SoCs so
>> switch the Kconfig depends to ARCH_QCOM.
>>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>> ---
>> Linus,
>>
>> If you can ack this I'll send it via linux-qcom/arm-soc tree's
>>
>> thanks
>>
>> - k
>
> ping.

Linus is slow to answer for some reason, but I guess that as the
co-maintainer my Ack would do for such a simple patch?

Acked-by: Alexandre Courbot <gnurou@gmail.com>

Linus, please rap on my knuckles if you feel I overstepped.
