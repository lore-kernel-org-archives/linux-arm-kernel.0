From: jeongbae.seo@samsung.com (Jeongbae Seo)
Date: Tue, 05 Oct 2010 15:46:51 +0900
Subject: [PATCH 2/5] ARM: S5PV310: Add HSMMC support into S5PV310 and
	S5PC210
In-Reply-To: <012c01cb63b3$b7053a20$250fae60$%szyprowski@samsung.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-3-git-send-email-jeongbae.seo@samsung.com>
	<012c01cb63b3$b7053a20$250fae60$%szyprowski@samsung.com>
Message-ID: <001201cb6459$1b3c1360$51b43a20$%seo@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> Hello,
> 
> I'm sorry for a late replay, I've just noticed this patch and have some
> comments.
> 
> On Thursday, September 16, 2010 10:37 AM Jeongbae Seo wrote:
> 
> > From: Hyuk Lee <hyuk1.lee@samsung.com>
> >
> > This patch adds to use of HSMMC on S5PV310 and S5PC210.
> > The HSMMC platform data like card detect, data bus width
> > and capability is configured.
> >
> > Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> > Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> > ---
> >  arch/arm/mach-s5pv310/cpu.c                |    7 +++
> >  arch/arm/mach-s5pv310/mach-smdkc210.c      |   50
> ++++++++++++++++++++++++
> >  arch/arm/mach-s5pv310/mach-smdkv310.c      |   50
> ++++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/sdhci.h |   57
> ++++++++++++++++++++++++++++
> >  4 files changed, 164 insertions(+), 0 deletions(-)
> 
> IMHO, changes to arch/arm/mach-s5pv310/{cpu.c, include/plat/sdhci.h}
> should be separated from changes to board specific changes
> (arch/arm/mach-s5pv310/mach-smdk*.c), so this patch should be split
> into 2 separate patches.

Hi, Marek

Okay, I'll make it as two patches.
Thanks for your comments.

Best Regards
Jeongbae Seo
