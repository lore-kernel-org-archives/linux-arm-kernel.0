From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Nov 2018 14:59:23 +0000
Subject: [PATCH v10 00/22] kasan: add software tag-based mode for arm64
In-Reply-To: <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <CAAeHK+yOsP7V0gPu7EpqCbJZqbGQMZbAp6q1+=0dNGC24reyWg@mail.gmail.com>
Message-ID: <20181107145922.GD2623@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 03:56:03PM +0100, Andrey Konovalov wrote:
> On Tue, Nov 6, 2018 at 6:30 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > This patchset adds a new software tag-based mode to KASAN [1].
> > (Initially this mode was called KHWASAN, but it got renamed,
> >  see the naming rationale at the end of this section).
> 
> [...]
> 
> > Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Hi Andrew,
> 
> This patchset has now been reviewed-by KASAN maintainers. Could you
> take a look and consider taking this into the -mm tree?

I would much prefer to take the arm64 parts (which still need to be reviewed
by Catalin afaict) via the arm64 tree, so please can you split those out
separately?

Will
