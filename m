From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 13 Jan 2015 10:43:59 +0100
Subject: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
In-Reply-To: <54B4D9E1.10400@samsung.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com>
 <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
 <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk>
 <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk>
 <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk>
 <54B4ABFB.5000501@samsung.com> <54B4D9E1.10400@samsung.com>
Message-ID: <54B4E8DF.90807@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joonyoung,

On 01/13/2015 09:40 AM, Joonyoung Shim wrote:
>>> >> These are the changes I have now [0]. Please let me know what you think.
>>> >>
>> > 
>> > Good, it's working with your patch without u-boot changes and reverting
>> > of commit 2ed127697eb.
>> >
> But i also get stripe hdmi output if hdmi/mixer drivers aren't defered
> probed, because DISP1 power domain isn't disabled on booting by defered
> probe so is always on.

Could you please elaborate on this? I'm not sure I undestood what you meant
so it would be great if you can give me the steps to reproduce your issue.

Best regards,
Javier
