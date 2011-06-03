From: prakity@marvell.com (Philip Rakity)
Date: Fri, 3 Jun 2011 14:08:18 -0700
Subject: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
In-Reply-To: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Message-ID: <FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Please update mmp2 and pxa defconfigs.

regards,

Philip

On Jun 3, 2011, at 2:48 AM, zhangfei gao wrote:

> v2->v3, modify according to Arnd and Philip suggestion.
> 
> Here are patches to provide separate sdhci driver for mmp2 and pxa910
> based on sdhci-platfm.
> Rename to sdhci-pxav3.c and sdhci-pxav2.c
> Remove sdhci-pxa.c, which is used to share among pxa serious, since
> under this method, platform difference have to be put under arch/arm,
> which is not easy to track.
> As a result, mmp2 mmc resource should be updated accordingly.
