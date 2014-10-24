From: mina86@mina86.com (Michal Nazarewicz)
Date: Fri, 24 Oct 2014 18:34:46 +0200
Subject: [PATCH 1/4] mm: cma: Don't crash on allocation if CMA area can't
 be activated
In-Reply-To: <1463193.4qGZjcvNod@avalon>
References: <1414074828-4488-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414074828-4488-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <xa1tmw8mlobz.fsf@mina86.com> <1463193.4qGZjcvNod@avalon>
Message-ID: <xa1tfved2zq1.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thursday 23 October 2014 18:53:36 Michal Nazarewicz wrote:
>> As a matter of fact, this is present in kernels earlier than 3.17 but in
>> the 3.17 the code has been moved from drivers/base/dma-contiguous.c to
>> mm/cma.c so this might require separate stable patch.

On Fri, Oct 24 2014, Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> That could be done, but I'm not sure if it's really worth it. The bug only 
> occurs when the CMA zone activation fails. I've ran into that case due to a 
> bug introduced in v3.18-rc1, but this shouldn't be the case for older kernel 
> versions.

Fair enough.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
