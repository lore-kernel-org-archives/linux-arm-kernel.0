From: mina86@mina86.com (Michal Nazarewicz)
Date: Thu, 26 Jan 2012 16:38:28 +0100
Subject: [PATCHv19 00/15] Contiguous Memory Allocator
In-Reply-To: <201201261531.40551.arnd@arndb.de>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <201201261531.40551.arnd@arndb.de>
Message-ID: <op.v8o62ey93l0zgt@mpn-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jan 2012 16:31:40 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> I haven't followed the last two releases so closely. It seems that
> in v17 the movable pages with pending i/o was still a major problem
> but in v18 you added a solution. Is that right? What is still left
> to be done here then?

In the current version, when allocation fails because of a page with
pending I/O, CMA automatically tries allocation in another region.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
