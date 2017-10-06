From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 Oct 2017 11:28:56 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <CAK8P3a1BkwquyVgRAsRgt2d5jv7TGoKPhA_gA0p+UQ9Spu_g2w@mail.gmail.com>
References: <20171005120914.465582-1-arnd@arndb.de>
 <CAMuHMdXjD-MpW9sqKtdUasizN8YkWuzChNyduyHz7p-cz38VBg@mail.gmail.com>
 <CAK8P3a1BkwquyVgRAsRgt2d5jv7TGoKPhA_gA0p+UQ9Spu_g2w@mail.gmail.com>
Message-ID: <20171006092856.GI7734@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 10:29:47PM +0200, Arnd Bergmann wrote:
> On Thu, Oct 5, 2017 at 2:25 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Oct 5, 2017 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>  arch/arm/mach-shmobile/headsmp-apmu.S | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-shmobile/headsmp-apmu.S b/arch/arm/mach-shmobile/headsmp-apmu.S
> >> index db4743d2bf91..5672b5849401 100644
> >> --- a/arch/arm/mach-shmobile/headsmp-apmu.S
> >> +++ b/arch/arm/mach-shmobile/headsmp-apmu.S
> >
> > As this hasn't been pulled into arm-soc yet (pull request sent though),
> > perhaps Simon should squash this fix into the original commit?
> > Should we rename headsmp-apmu.S to head-apmu.S?
> 
> I'm fine with it either way, just do whatever works best for you here.

My preference is to send a second pull request with this patch on top of the
previous pull request. Arnd does that work for you?
