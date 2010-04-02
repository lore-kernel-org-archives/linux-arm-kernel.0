From: minchan.kim@gmail.com (Minchan Kim)
Date: Fri, 2 Apr 2010 14:13:09 +0900
Subject: [Question] race condition in mm/page_alloc.c regarding page->lru?
In-Reply-To: <g2g5f4a33681004012051wedea9538w9da89e210b731422@mail.gmail.com>
References: <i2i5f4a33681003312105m4cd42e9ayfe35cc0988c401b6@mail.gmail.com>
	<g2g5f4a33681004012051wedea9538w9da89e210b731422@mail.gmail.com>
Message-ID: <o2j28c262361004012213tc9fdebc7yc535f4130a86e644@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 2, 2010 at 12:51 PM, TAO HU <tghk48@motorola.com> wrote:
> 2 patches related to page_alloc.c were applied.
> Does anyone see a connection between the 2 patches and the panic?

Seem to not related to the problem.
I don't have seen the problem before.

Could you git-bisect to make sure which patch makes bug?
Is it reproducible?
Can I reproduce it in QEMU-goldfish?

-- 
Kind regards,
Minchan Kim
