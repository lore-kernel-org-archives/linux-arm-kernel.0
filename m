From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Nov 2010 09:57:05 -0000
Subject: [PATCH 2/5] ARM: perf: avoid exposing internal stop function for
	v6 PMU
In-Reply-To: <20101115190228.GB2764@pulham.picochip.com>
References: <1289842263-21241-1-git-send-email-will.deacon@arm.com>
	<1289842263-21241-3-git-send-email-will.deacon@arm.com>
	<20101115190228.GB2764@pulham.picochip.com>
Message-ID: <006001cb8574$a03883f0$e0a98bd0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> On Mon, Nov 15, 2010 at 05:31:00PM +0000, Will Deacon wrote:
> > Unlike other pmu functions, armv6pmu_pmu_stop is not declared static.
> > This patch adds the missing keyword.
> >
> > Cc: Jamie Iles <jamie.iles@picochip.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> Yep, good spot. Btw, my employer has changed to Exchange for our email and it
> has a habit of munging patches on the way in so I'll have to switch to my
> personal email now!

Urgh! We have to use Exchange too and it makes a total mess of patches.
You can run dos2unix and write a script to fix wrapped lines but you get
into trouble when there is trailing whitespace in a file and diff uses
that line for context. Then I usually resort to hexdump, which takes far
too long to be practical for larger patches.

> Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks. I'll use this email address in future.

Will
