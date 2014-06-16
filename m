From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Mon, 16 Jun 2014 14:18:31 +0900
Subject: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <xa1tegyujvxv.fsf@mina86.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE>
 <xa1toaxyjym3.fsf@mina86.com> <xa1tegyujvxv.fsf@mina86.com>
Message-ID: <20140616051830.GA23210@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 11:53:16AM +0200, Michal Nazarewicz wrote:
> On Thu, Jun 12 2014, Michal Nazarewicz <mina86@mina86.com> wrote:
> > I used ?function(arg1, arg2, ?)? at the *beginning* of functions when
> > the arguments passed to the function were included in the message.  In
> > all other cases I left it at just ?function:? (or just no additional
> > prefix).  IMO that's a reasonable strategy.
> 
> At closer inspection, I realised drivers/base/dma-contiguous.c is
> Marek's code, but the above I think is still reasonable thing to do, so
> I'd rather standardise on having ?function(?)? only at the beginning of
> a function.  Just my 0.02 CHF.

Hello,

Now, I realize that these changes aren't needed in this patchset, so I
simplify this patch just to remove redundant 'CMA' prefix. Other things
can be done after merging if we need.

Thanks.
