From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Mon, 19 Nov 2018 10:08:25 +0100
Subject: [PATCH v2 00/25] at24: remove
In-Reply-To: <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181118170329.788778a8@bbrezillon>
 <CAMRc=MfXWW9siNZNkocxmTU7mnoQO0KpeHQ3JmLcEfNscqCbDQ@mail.gmail.com>
Message-ID: <20181119100825.277b1f97@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2018 09:58:46 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> niedz., 18 lis 2018 o 17:03 Boris Brezillon
> <boris.brezillon@bootlin.com> napisa?(a):
> >
> > On Tue, 13 Nov 2018 15:01:08 +0100
> > Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >  
> > > As far as merging of this series goes: I'd like to avoid dragging it over
> > > four releases. The series is logically split into five groups:
> > >
> > > patches 1-2: nvmem and mtd changes
> > > patches 3-9: davinci arch-specific changes
> > > patches 10-13: networking changes
> > > patches 14-24: davinci specific again
> > > patch 25: final at24 change
> > >
> > > With that I believe we can do the following: Greg KH could pick up the
> > > first two patches into his char-misc tree.  
> >
> > The char-misc tree? Why not the MTD or NVMEM tree?
> >  
> 
> There is no NVMEM tree - Srinivas sends his patches to Greg to be
> applied to char-misc.

Okay, I didn't know that.

> 
> The second patch depends on the first one so in order to avoid more
> merging problems I suggested that the MTD patch go through char-misc
> as well. If you see a better solution, please let me know.

No that's fine, as long as I have an immutable tag/branch I can pull if
needed.
