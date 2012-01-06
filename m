From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Jan 2012 13:58:57 -0800
Subject: [GIT PULL] imx: pm changes for 3.3, part 2
In-Reply-To: <20120105061905.GE14741@S2100-06.ap.freescale.net>
References: <20120105061905.GE14741@S2100-06.ap.freescale.net>
Message-ID: <CAOesGMj3J038_r4ePNdo58GNpy=uhtjTL-a2GDaGgiu6=gOWLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 4, 2012 at 10:19 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Arnd, Olof,
>
> Please pull the following two patches for 3.3.
>
> Regards,
> Shawn
>
> The following changes since commit 5f0a6e2d503896062f641639dacfe5055c2f593b:
>
> ?Linux 3.2-rc7 (2011-12-23 21:51:06 -0800)
>
> are available in the git repository at:
> ?git://git.linaro.org/people/shawnguo/linux-2.6.git imx/pm2
>
> Shawn Guo (2):
> ? ? ?ARM: imx6: fix v7_invalidate_l1 by adding I-Cache invalidation
> ? ? ?ARM: imx6: remove __CPUINIT annotation from v7_invalidate_l1

Thanks, since both of these look like valid fixes (and not features),
I've added them to imx6/pm and next/pm for 3.3.


-Olof
