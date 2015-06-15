From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Jun 2015 08:57:43 +0900
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <557EEDFB.7080502@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
 <557AB00C.5040606@arm.com> <557AC23D.8040602@collabora.co.uk>
 <557AC85E.5070705@arm.com> <557AD728.7090908@collabora.co.uk>
 <557B34A7.4090507@collabora.co.uk>
 <CAD=FV=UQF+n8AjSXYajqUb0qswcoUrSgnsasV82JaS3dBtNO8Q@mail.gmail.com>
 <557E82BC.7080203@collabora.co.uk> <557E947B.3030804@arm.com>
 <557EE890.2050001@collabora.co.uk> <557EEA6C.6020002@arm.com>
 <557EEDFB.7080502@collabora.co.uk>
Message-ID: <557F6677.8080507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.06.2015 00:23, Javier Martinez Canillas wrote:
(...)
>>> To do a more intrusive change, I should better understand the interactions
>>> between the Exynos pinctrl / GPIO, interrupt combiner and the GIC and in the
>>> meantime S2R will continue to be broken on these platforms unless someone
>>> more familiar with all this could point me in the right direction.
>>>
>>
>> As I said I am fine with this patch for now and I don't want to block it.
>>
> 
> Thanks a lot, Krzysztof who is one of the Exynos maintainers has also agreed
> with the patch so hopefully this can land sooner rather than later.

I assume this will go through irqchip tree, right?

Best regards,
Krzysztof
