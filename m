From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 30 Jan 2013 15:59:11 +0000
Subject: [GIT PULL] vexpress: drivers for v3.9
In-Reply-To: <1359542283.8090.32.camel@hornet>
References: <1359484450.8090.27.camel@hornet>
 <CAOesGMinJef-9OsKi0LGB0W6i73sgyUqhm2Mie4gyC2JLjnd1Q@mail.gmail.com>
 <1359542283.8090.32.camel@hornet>
Message-ID: <1359561551.3094.17.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-01-30 at 10:38 +0000, Pawel Moll wrote:
> In the meantime, could you please take the other patch please? I mean:
> 
> > > Catalin Marinas (1):
> > >       arm: Move sp810.h to include/linux/amba/
> 
> I can rework the branch to contain this patch only and send a new pull
> request if you prefer.

As Samuel will take the LEDs patch through his tree, I've regenerated
the branch, so:

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/drivers-for-3.9

for you to fetch changes up to da660b4a3b15caea9c198c4f26d1cf7023df92fc:

  arm: Move sp810.h to include/linux/amba/ (2013-01-30 15:55:45 +0000)

----------------------------------------------------------------
Versatile Express related driver updates for 3.9:
* Move sp810 header to a more generic location,
  mainly to share it with arm64

----------------------------------------------------------------
Catalin Marinas (1):
      arm: Move sp810.h to include/linux/amba/

 arch/arm/plat-spear/restart.c                                 |    2 +-
 drivers/clk/versatile/clk-vexpress.c                          |    3 +--
 {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h |    0
 3 files changed, 2 insertions(+), 3 deletions(-)
 rename {arch/arm/include/asm/hardware => include/linux/amba}/sp810.h (100%)
