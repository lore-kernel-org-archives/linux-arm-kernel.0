From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Mar 2012 15:26:16 -0800
Subject: [GIT PULL] Urgent pre-emptive fixes for next merge window
In-Reply-To: <CAOesGMiHU81Y8yiD5rZT5v2SRR419LggUYBB8C_j1Vq2Ge_z6w@mail.gmail.com>
References: <20120307225946.GK12083@atomide.com>
 <CAOesGMiHU81Y8yiD5rZT5v2SRR419LggUYBB8C_j1Vq2Ge_z6w@mail.gmail.com>
Message-ID: <20120307232615.GL12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [120307 14:41]:
> On Wed, Mar 7, 2012 at 2:59 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > The following changes since commit d82ba9954b6b2c4ac91ec6f6f42be8c5215d0619:
> > ?Peter Ujfalusi (1):
> > ? ? ? ?OMAP4: dma: Correct CPU version check for dma_common_ch_end
> >
> > are available in the git repository at:
> >
> > ?git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical-part2
> 
> Pulled, thanks.

Thanks. Once the remoteproc updates are there, things build
even without IOMMU_SUPPORT selected.

So that leaves the include "linux/bug.h" issue and the
ASoC cpu_is_omap4430 issue. I'll let Peter know about the
ASoC issue.

Regards,

Tony
