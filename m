From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 22 Aug 2012 13:41:42 +0800
Subject: [PATCH] drivers/dma/sirf-dma.c: fix usage of devm functions
In-Reply-To: <alpine.DEB.2.02.1208220729440.1966@localhost6.localdomain6>
References: <1344069330-29569-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345608994.1895.73.camel@vkoul-udesk3>
 <CAGsJ_4yjzE3eNGz=AA7gGxGNkjBH8bKRAUsYXcG+A1p8PtOQPw@mail.gmail.com>
 <alpine.DEB.2.02.1208220729440.1966@localhost6.localdomain6>
Message-ID: <CAGsJ_4wkyY7VkrgMwGwmFF4kpGiGEtU8Ox46G-yOspAi27Lqgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/22 Julia Lawall <julia.lawall@lip6.fr>:
> On Wed, 22 Aug 2012, Barry Song wrote:
>
>> 2012/8/22 Vinod Koul <vinod.koul@linux.intel.com>:
>>>
>>> On Sat, 2012-08-04 at 10:35 +0200, Julia Lawall wrote:
>>>>
>>>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>>>
>>>> Fix some problems with the use of devm_ functions.
>>>
>>> Applied, thanks
>>
>>
>> the git log "drivers/dma/sirf-dma.c: fix usage of devm functions"
>> should be fixed.
>
>
> What do you suggest?  The patch is about problems with the use of
> devm_kzalloc, devm_ioremap, and devm_request_irq.

i mean the prefix

dmaengine: sirf: .............

>
> thanks,
> julia

-barry
