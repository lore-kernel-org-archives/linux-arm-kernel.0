From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 31 Mar 2015 08:49:39 +0200
Subject: [PATCH 1/2] drivers/rtc/rtc-s3c.c: Integrate Exynos3250 into
 S3C6410
In-Reply-To: <20150331002709.GF3849@piout.net>
References: <1427728773-29065-1-git-send-email-k.kozlowski@samsung.com>
 <1427728773-29065-2-git-send-email-k.kozlowski@samsung.com>
 <20150331002709.GF3849@piout.net>
Message-ID: <CABxcv==+h8R-tL9D5OXmYsuYfs_cLATViZ3N1veZwZBZF=fu0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,

On Tue, Mar 31, 2015 at 2:27 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> nitpick: I would prefer rtc: rtc-s3c instead of drivers/rtc/rtc-s3c.c
>

Yes but Krzysztof is following the convention used in drivers/rtc/
which I think is the correct thing to do even when it's different from
what is used all over the kernel.

> On 30/03/2015 at 17:19:32 +0200, Krzysztof Kozlowski wrote :
>> There are now no differences between RTC on Exynos3250 and S3C6410.
>> Merge everything into one so duplicated code could be removed.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
