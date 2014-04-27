From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Apr 2014 20:54:43 +0100
Subject: randconfig failures - MMC + trusted foundations
In-Reply-To: <CAOesGMhuMHnnHQ7fPFTHPX9Z2-T8MG7B-=CPOwCe=EFS232M=g@mail.gmail.com>
References: <20140427093250.GA26756@n2100.arm.linux.org.uk>
 <CAAVeFuJ2=fWamF6xBAJLv1kEEhBVgWMj-PY0gxouo6-NOE9OfQ@mail.gmail.com>
 <20140427103302.GB26756@n2100.arm.linux.org.uk>
 <CAOesGMhuMHnnHQ7fPFTHPX9Z2-T8MG7B-=CPOwCe=EFS232M=g@mail.gmail.com>
Message-ID: <20140427195443.GF26756@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 12:46:06PM -0700, Olof Johansson wrote:
> On Sun, Apr 27, 2014 at 3:33 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I received a report from someone else last week (in the mmc patch series
> > I posted) that Chris has already merged this into his mmc tree, so I
> > think it would need to be a follow on patch.
> 
> Huh, I don't see the patches in mmc-next. Did they get applied
> somewhere else? They're not in linux-next either.
> 
> Timing is good though; I was hoping to revisit that patch set this week.

Ah, it wasn't the main patch, it was the one adding mmc_of_parse to dw_mmc.c:

| I didn't know which version you have checked.
| But I have known that mmc_of_parse() have already included at mmc-next
| repository.
| 
| commit 6ca5c60605dde3420ce7fee6f93ec4a7c7924848
| Author: Jaehoon Chung <jh80.chung@gmail.com>
| Date:   Mon Mar 3 11:36:41 2014 +0900
| 
|     mmc: dw_mmc: use the mmc_of_parse() instead of local parser

as part of the big 70-odd sdhci/cubox-i mmc patch series I posted last
week.

So I'll continue carrying your versions privately for the time being.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
