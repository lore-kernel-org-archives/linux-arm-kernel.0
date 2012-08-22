From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Aug 2012 07:30:44 +0200 (CEST)
Subject: [PATCH] drivers/dma/sirf-dma.c: fix usage of devm functions
In-Reply-To: <CAGsJ_4yjzE3eNGz=AA7gGxGNkjBH8bKRAUsYXcG+A1p8PtOQPw@mail.gmail.com>
References: <1344069330-29569-1-git-send-email-Julia.Lawall@lip6.fr>
 <1345608994.1895.73.camel@vkoul-udesk3>
 <CAGsJ_4yjzE3eNGz=AA7gGxGNkjBH8bKRAUsYXcG+A1p8PtOQPw@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1208220729440.1966@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Aug 2012, Barry Song wrote:

> 2012/8/22 Vinod Koul <vinod.koul@linux.intel.com>:
>> On Sat, 2012-08-04 at 10:35 +0200, Julia Lawall wrote:
>>> From: Julia Lawall <Julia.Lawall@lip6.fr>
>>>
>>> Fix some problems with the use of devm_ functions.
>> Applied, thanks
>
> the git log "drivers/dma/sirf-dma.c: fix usage of devm functions"
> should be fixed.

What do you suggest?  The patch is about problems with the use of 
devm_kzalloc, devm_ioremap, and devm_request_irq.

thanks,
julia

>
>>
>>
>> --
>> ~Vinod
>>
>
> -barry
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
