From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 4 May 2015 21:10:27 +0300
Subject: [PATCH 2/3] ARM: s3c24xx: Add DMA resources for SDI and I2S
In-Reply-To: <CAJKOXPewZb_26GgA27T8fkXvTrg3FEYMkErapqoaMaSHDNy3ug@mail.gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
 <1430676910-30657-2-git-send-email-anarsoul@gmail.com>
 <CAJKOXPewZb_26GgA27T8fkXvTrg3FEYMkErapqoaMaSHDNy3ug@mail.gmail.com>
Message-ID: <CA+E=qVeyDvySOfLRL9PKYm5c9YkZhdt3OHrh4n1sXOusgy+qJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 4, 2015 at 6:45 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-05-04 3:15 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
>> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> "Add DMA resources for SDI and I2S".,.. what for? why? The commit
> message would be appropriate place to put such details.

Because SDI and I2S drivers need these resources to setup DMA channel properly.
Would you like me to resend the patch with this explanation?

> The patch itself looks good.
>
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> Best regards,
> Krzysztof
