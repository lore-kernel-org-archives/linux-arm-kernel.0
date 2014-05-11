From: horms@verge.net.au (Simon Horman)
Date: Sun, 11 May 2014 10:04:56 +0900
Subject: [PATCH 00/04] ARM: shmobile: Use shmobile_init_delay() on r8a7740
In-Reply-To: <CAMuHMdWkZ=pTCs_HgBnjPPExLj-fU4ywZq-aHUrpdLXLGT3WSw@mail.gmail.com>
References: <20140507233219.29712.9253.sendpatchset@w520>
 <CAMuHMdWkZ=pTCs_HgBnjPPExLj-fU4ywZq-aHUrpdLXLGT3WSw@mail.gmail.com>
Message-ID: <20140511010456.GA31760@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 09:54:58AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Thu, May 8, 2014 at 1:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: Use shmobile_init_delay() on r8a7740
> >
> > [PATCH 01/04] ARM: shmobile: Add r8a7740 Maximum CPU Frequency to DTS
> > [PATCH 02/04] ARM: shmobile: Use r8a7740 DT CPU Frequency in common case
> > [PATCH 03/04] ARM: shmobile: Use r8a7740 DT CPU Frequency for Armadillo DT Ref
> > [PATCH 04/04] ARM: shmobile: Remove unused r8a7740_init_delay()
> >
> > Convert r8a7740 to rely on shmobile_init_delay() instead of using a per-SoC
> > delay setup function. This is a cleanup towards enabling Multiplatform support
> > for the r8a7740 SoC.
> 
> Thanks!
> 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Tested-by: Geert Uytterhoeven <geert@glider.be>

Thanks, I have queued these up.
