From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 15 Jun 2011 11:26:47 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106142242.25157.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<20110614170158.GU2419@fooishbar.org>
	<BANLkTi=cJisuP8=_YSg4h-nsjGj3zsM7sg@mail.gmail.com>
	<201106142242.25157.arnd@arndb.de>
Message-ID: <op.vw31uxxl3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2011 22:42:24 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> * We still need to solve the same problem in case of IOMMU mappings
>   at some point, even if today's hardware doesn't have this combination.
>   It would be good to use the same solution for both.

I don't think I follow.  What does IOMMU has to do with CMA?

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
