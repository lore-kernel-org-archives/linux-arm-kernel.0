From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Aug 2017 13:47:54 -0700
Subject: [GIT PULL 2/4] defconfig changes for omaps for v4.14
In-Reply-To: <CAK8P3a2CaT4KxGHJRkyuu+0i_NGN876E7X8YZ+dm8-27PG5ffQ@mail.gmail.com>
References: <-2831898822533480273@unknownmsgid>
 <CAK8P3a2CaT4KxGHJRkyuu+0i_NGN876E7X8YZ+dm8-27PG5ffQ@mail.gmail.com>
Message-ID: <20170816204754.GK8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [170816 13:45]:
> On Tue, Aug 15, 2017 at 6:52 PM, Tony Lindgren <tony@atomide.com> wrote:
> > From: "Tony Lindgren" <tony@atomide.com>
> >
> > The following changes since commit 9b51f04424e17051a89ab32d892ca66b2a104825:
> >
> >   Merge branch 'parisc-4.13-2' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux (2017-07-05 17:41:31 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.14/defconfig-signed
> >
> > for you to fetch changes up to 6a60a2aca111fd71c5229dbcb3de8ecf0e0e9a12:
> >
> >   ARM: omap2plus_defconfig: Enable LP87565 (2017-08-14 10:33:49 -0700)
> >
> > ----------------------------------------------------------------
> > Defconfig updates for omaps for v4.14 to enable DP83867
> > phy driver on dra72x and dra71x evm, and LP87565 that is
> > on dra76-evm.
> 
> Pulled into next/defconfig, thanks!
> 
> Should we enable those drivers on multi_v7_defconfig as well?

Yeah, I actually started a series enabling options for
multi_v7_defconfig from omap2plus_defconfig before I went
offline :) Will continue on that at some point.

Regards,

Tony
