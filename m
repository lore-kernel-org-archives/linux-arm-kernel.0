From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 14 Jun 2011 15:55:19 +0200
Subject: [PATCH 08/10] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201106141549.29315.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106101821.50437.arnd@arndb.de>
	<006a01cc29a9$1394c330$3abe4990$%szyprowski@samsung.com>
	<201106141549.29315.arnd@arndb.de>
Message-ID: <op.vw2jmhir3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 Jun 2011 15:49:29 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> Please explain the exact requirements that lead you to defining multiple
> contexts.

Some devices may have access only to some banks of memory.  Some devices
may use different banks of memory for different purposes.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
