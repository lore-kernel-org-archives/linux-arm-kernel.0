From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 20 Jun 2014 18:36:55 +0200
Subject: [PATCHv2] mm: page_alloc: fix CMA area initialisation when
 pageblock > MAX_ORDER
In-Reply-To: <1403279282.755.23.camel@deneb.redhat.com>
References: <1402522435-13884-1-git-send-email-msalter@redhat.com>
 <alpine.DEB.2.02.1406111557030.27885@chino.kir.corp.google.com>
 <xa1t61jzwfo6.fsf@mina86.com> <1403201524.32688.62.camel@deneb.redhat.com>
 <xa1td2e41xs2.fsf@mina86.com> <1403279282.755.23.camel@deneb.redhat.com>
Message-ID: <xa1tha3fv8pk.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20 2014, Mark Salter <msalter@redhat.com> wrote:
> This still isn't quite right. __free_pages can only take up to
> MAX_ORDER-1 (MAX_ORDER_NR_PAGES is 1 << (MAX_ORDER - 1)).

Good catch.  I'll send v3 in a few days then.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
