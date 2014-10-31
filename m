From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Oct 2014 21:48:54 +0100
Subject: [PATCH 3/3] ARM: Allow either FLATMEM or SPARSEMEM on the
 multi-v7 build
In-Reply-To: <CADtm3G5sUHY8+DLoUEFPtCqj7JBujGbM3FGEWQHje53TV2x5vg@mail.gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
 <1410488562-21863-3-git-send-email-cernekee@gmail.com>
 <CADtm3G5sUHY8+DLoUEFPtCqj7JBujGbM3FGEWQHje53TV2x5vg@mail.gmail.com>
Message-ID: <33276667.aYDcK8dzCe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 October 2014 13:12:46 Gregory Fong wrote:
> On Thu, Sep 11, 2014 at 7:22 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > ARMv7 chips with LPAE can often benefit from SPARSEMEM, as portions of
> > system memory can be located deep in the 36-bit address space.  Allow
> > FLATMEM or SPARSEMEM to be selectable at compile time; FLATMEM remains
> > the default.
> >
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> 
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
> 

Looking at the patch now, I see no reason why this should be tied to
ARMv7. Are there any problems we'd expect enabling it for all of
ARCH_MULTIPLATFORM?

	Arnd
