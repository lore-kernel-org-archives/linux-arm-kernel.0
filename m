From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 1 Oct 2018 15:18:34 +0200
Subject: [PATCH] MAINTAINERS: fix pattern in ARM/Synaptics berlin SoC
 section
In-Reply-To: <20180929130003.5dc79bed@xhacker.debian>
References: <20180929130003.5dc79bed@xhacker.debian>
Message-ID: <CAK8P3a2dPpcV08vhsdtr9CD-+-u5VUhSNRhRptmP8bodfF+DSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 29, 2018 at 7:03 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Berlin SoC files has been moved from marvell dir to synaptics dir, but
> commit bc52497a595d ("MAINTAINERS: update entry for ARM/berlin") didn't
> update the dir accordingly. This patch fixes it.
>
> From another side, new derivative SoCs from Synaptics may not be named
> as berlin*, so let's update the entries accordingly.
>
> Fixes: bc52497a595d ("MAINTAINERS: update entry for ARM/berlin")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Reported-by: Joe Perches <joe@perches.com>


Applied to next/soc, thanks!

       Arnd
