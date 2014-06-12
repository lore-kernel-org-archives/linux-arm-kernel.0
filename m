From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 12 Jun 2014 11:53:16 +0200
Subject: [PATCH v2 01/10] DMA, CMA: clean-up log message
In-Reply-To: <xa1toaxyjym3.fsf@mina86.com>
References: <1402543307-29800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1402543307-29800-2-git-send-email-iamjoonsoo.kim@lge.com>
 <87y4x2pwnk.fsf@linux.vnet.ibm.com>
 <20140612055358.GA30128@js1304-P5Q-DELUXE> <xa1toaxyjym3.fsf@mina86.com>
Message-ID: <xa1tegyujvxv.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12 2014, Michal Nazarewicz <mina86@mina86.com> wrote:
> I used ?function(arg1, arg2, ?)? at the *beginning* of functions when
> the arguments passed to the function were included in the message.  In
> all other cases I left it at just ?function:? (or just no additional
> prefix).  IMO that's a reasonable strategy.

At closer inspection, I realised drivers/base/dma-contiguous.c is
Marek's code, but the above I think is still reasonable thing to do, so
I'd rather standardise on having ?function(?)? only at the beginning of
a function.  Just my 0.02 CHF.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
