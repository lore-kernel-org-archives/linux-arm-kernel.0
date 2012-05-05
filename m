From: marex@denx.de (Marek Vasut)
Date: Sat, 5 May 2012 16:32:14 +0200
Subject: [PATCH v2 2/5] dma: mxs-dma: make platform_device_id more generic
In-Reply-To: <CAAQ0ZWTztNaqwjVA257N+42PByhH1k1Gswi18S9G=dHEaO5PhQ@mail.gmail.com>
References: <1336133539-13465-1-git-send-email-b29396@freescale.com>
 <201205051512.17972.marex@denx.de>
 <CAAQ0ZWTztNaqwjVA257N+42PByhH1k1Gswi18S9G=dHEaO5PhQ@mail.gmail.com>
Message-ID: <201205051632.14882.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 5 May 2012 21:12, Marek Vasut <marex@denx.de> wrote:
> > Can't the patches be reordered then to avoid adding this altogether?
> 
> Maybe.  But I do not think it's really worth the effort.
> 
> > You don't have to add dead code in this patch and re-add it when needed.
> > Or fix the macro to take the parameter then, though I don't understand
> > why you'd want to take it and then hide it.
> 
> I do not completely understand the comment.  My point is the problem
> is in the existing code.  It's not introduced by Dong's patch.  The
> problem should be fixed in another patch, and we do not want to do
> several things in one patch.

Then order such a patch before Dong's series then? It'd all be clear, without 
compromises.

> 
> Regards,
> Shawn

Best regards,
Marek Vasut
