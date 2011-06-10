From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 10 Jun 2011 12:24:51 +0100
Subject: [PATCH 02/10] lib: genalloc: Generic allocator improvements
In-Reply-To: <1307699698-29369-3-git-send-email-m.szyprowski@samsung.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<1307699698-29369-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20110610122451.15af86d1@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am curious about one thing

Why do we need this allocator. Why not use allocate_resource and friends.
The kernel generic resource handler already handles object alignment and
subranges. It just seems to be a surplus allocator that could perhaps be
mostly removed by using the kernel resource allocator we already have ?

Alan
