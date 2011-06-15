From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 15 Jun 2011 13:30:48 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <201106151320.42182.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106142242.25157.arnd@arndb.de>
	<op.vw31uxxl3l0zgt@mnazarewicz-glaptop>
	<201106151320.42182.arnd@arndb.de>
Message-ID: <op.vw37lm1a3l0zgt@mnazarewicz-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2011 13:20:42 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> The point is that on the higher level device drivers, we want to
> hide the presence of CMA and/or IOMMU behind the dma mapping API,
> but the device drivers do need to know about the bank properties.

Gotcha, thanks.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Michal "mina86" Nazarewicz    (o o)
ooo +-----<email/xmpp: mnazarewicz@google.com>-----ooO--(_)--Ooo--
