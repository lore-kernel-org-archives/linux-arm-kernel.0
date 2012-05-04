From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 May 2012 10:53:54 -0700
Subject: [PATCH] ARM: OMAP2+: dma: Define dma capabilities register
 bitfields and use them.
In-Reply-To: <CAMQu2gzDgPQwrv4oRCeUKEeYq4Tpu=X=SBSFjKzeTb7TzDsb9A@mail.gmail.com>
References: <1336116582-11099-1-git-send-email-r.sricharan@ti.com>
 <CAMQu2gzDgPQwrv4oRCeUKEeYq4Tpu=X=SBSFjKzeTb7TzDsb9A@mail.gmail.com>
Message-ID: <20120504175353.GJ5613@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120504 00:37]:
> On Fri, May 4, 2012 at 12:59 PM, R Sricharan <r.sricharan@ti.com> wrote:
> > The system dma module has capabiities register indicating
> > the support for descriptor loading, constant fill, etc.
> > Use this instead of OMAP revision check to identify the features
> > supported runtime.
> >
> > This avoids patching the code for feature SOCs which has
> > those capabilities.
> >
> > Signed-off-by: R Sricharan <r.sricharan@ti.com>
> > ---
> > ?arch/arm/mach-omap2/dma.c ? ? ? ? ? ? | ? 11 +++++++----
> > ?arch/arm/plat-omap/include/plat/dma.h | ? ?5 +++++
> > ?2 files changed, 12 insertions(+), 4 deletions(-)
> >
> Looks fine. Will add it to my clean-up series if no has
> any objection on the patch.

Yes this is nice.

Tony
