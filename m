From: horms@verge.net.au (Simon Horman)
Date: Wed, 21 May 2014 08:49:24 +0900
Subject: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7790
In-Reply-To: <CAMuHMdVHzp7sK8ufi9J35-ZaBXsvOZPrZDNcCwX8wTBSZpOpoA@mail.gmail.com>
References: <20140519233714.10496.31390.sendpatchset@w520>
 <CAMuHMdVHzp7sK8ufi9J35-ZaBXsvOZPrZDNcCwX8wTBSZpOpoA@mail.gmail.com>
Message-ID: <20140520234923.GA28186@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 09:48:08AM +0200, Geert Uytterhoeven wrote:
> On Tue, May 20, 2014 at 1:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > [PATCH 01/03] ARM: shmobile: Use r8a7790 DT CPU Frequency in common case
> > [PATCH 02/03] ARM: shmobile: Use r8a7790 DT CPU Frequency for Lager
> > [PATCH 03/03] ARM: shmobile: Remove unused r8a7790_init_early()
> >
> > Convert r8a7790 to rely on shmobile_init_delay() instead of using a per-SoC
> > delay setup function. Very similar to the r8a7791 implementation.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks I will queue these up.
