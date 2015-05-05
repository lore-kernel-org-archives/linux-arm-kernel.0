From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 5 May 2015 12:38:18 +0900
Subject: [PATCH 1/3] ARM: s3c24xx: add dma_coherent_mask for DMA devices
In-Reply-To: <CA+E=qVf5MLsdV+U82Smv-weKQ3eJAEob7J+hdbhtZ-E1qrOsYw@mail.gmail.com>
References: <1430676910-30657-1-git-send-email-anarsoul@gmail.com>
 <CAJKOXPfbF0RDPisY-PvKKKVT1kHDrR60b7VmcjTkco5UPm-WTg@mail.gmail.com>
 <CA+E=qVf5MLsdV+U82Smv-weKQ3eJAEob7J+hdbhtZ-E1qrOsYw@mail.gmail.com>
Message-ID: <CAJKOXPcjdnAyr+wxzfPtmw+-QQnQeBuUL-gMrnuEs-SvOYs1pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-05 2:54 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
> On Mon, May 4, 2015 at 6:42 AM, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> 2015-05-04 3:15 GMT+09:00 Vasily Khoruzhick <anarsoul@gmail.com>:
>>> Otherwise dma_alloc_coherent() fails.
>>
>> Could you say few more words about the failure?
>> Also the patch looks like a candidate for CC-stable along with Fixes tag.
>
> Hm, any call of dma_alloc_coherent() will fail for s3c24xx-dmac
> device. For example, asoc dmaengine driver. What exactly do
> you want me to precise?

Anything more than just "fails" would be welcome. Especially for
backporting to stable.

Best regards,
Krzysztof
