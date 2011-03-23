From: dwalker@fifo99.com (Daniel Walker)
Date: Wed, 23 Mar 2011 07:23:11 -0700
Subject: [Git pull] MSM for v2.6.39
In-Reply-To: <8yazkotpwk6.fsf@huya.qualcomm.com>
References: <8yazkotpwk6.fsf@huya.qualcomm.com>
Message-ID: <1300890191.6117.43.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 08:59 -0700, David Brown wrote:
> David Brown (16):
>       msm: Add CPU queries
>       msm: Generalize timer register mappings
>       msm: Generalize QGIC registers
>       msm: Add MSM 8960 cpu_is check
>       Merge branch 'msm-uart' into for-next
>       Merge branch 'msm-8960' into for-next
>       Merge branch 'msm-sdcc' into for-next
>       Merge branch 'msm-fb' into for-next
>       Merge branch 'msm-8960' into msm-core
>       msm: Remove broken register definition from trout
>       msm: Warning fix in trout gpio board file
>       Merge branch 'msm-core' into for-next
>       Merge branch 'msm-core' into for-next
>       Merge branch 'msm-core' into for-next
>       msm: Use explicit GPLv2 licenses
>       Merge remote branch 'rmk/for-linus' into for-linus 

Could you change the "for-next" name to something more interesting like
msm-for-linus .. I think it would be acceptable to just create
msm-for-linus during the merge window and merge all the sub-tree's into
that.

Daniel
