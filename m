From: horms@verge.net.au (Simon Horman)
Date: Thu, 4 Jul 2013 11:36:17 +0900
Subject: [PATCH v3] ARM: shmobile: lager: Add DT reference
In-Reply-To: <CANqRtoTD3Bgm775DhFhs2kn1+sSLb-pX89mFRoHrc2x4sRT_RQ@mail.gmail.com>
References: <1372838251-6314-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTD3Bgm775DhFhs2kn1+sSLb-pX89mFRoHrc2x4sRT_RQ@mail.gmail.com>
Message-ID: <20130704023614.GA435@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:21:10PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 3, 2013 at 4:57 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > This is sufficient to allow boot of the Lager board with
> > a console without boards-lager.c compiled into the kernel.
> > This is an example of a minimal but still useful initialisation
> > of the board using DT as much as possible.
> >
> > As such it is the same as the boot of Lager that can be achieved
> > without a board file. The intention of adding this file
> > is to facilitate further work to allow board specific devices to be
> > initialised via DT.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> >
> > v3
> > * Supply temporary machine_init call-back in lager-reference.c to
> >   initialise clocks and bring up SCIF and CMT in C. Magnus
> >   advised me that this is not desired in the SoC code.
> > * Add lager-reference to Makefile.boot
> >
> > v2
> > * Use recently added r8a7790_init_delay()
> 
> This looks good to me, thanks!
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12.
