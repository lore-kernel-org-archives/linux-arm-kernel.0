From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 18 Nov 2009 22:13:45 +0000
Subject: [PATCH 09/19] drivers: serial: add support for Samsung S5PC110
	SoC uart
In-Reply-To: <1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
	<1258551194-16018-10-git-send-email-m.szyprowski@samsung.com>
	<1b68c6790911180614y355f656fs828177ecc845ec8e@mail.gmail.com>
Message-ID: <20091118221345.GB4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2009 at 11:14:52PM +0900, jassi brar wrote:
> On Wed, Nov 18, 2009 at 10:33 PM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > From: Kyungmin Park <kyungmin.park@samsung.com>
> >
> > Samsung S5PC110 SoCs have UART that differs a bit from the one known
> > from the previous Samsung SoCs. This patch adds support for this new
> > driver.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

> Not just about this c110 patch: I think this string comparison thing
> isn't very neat.
> I think we'd better be doing it by indexing into an array of clock
> names(which can be
> defined in some platform specific code).

I don't mind changing to using a table, but the table is probably best
off here, closest to the UART drivers in question.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
