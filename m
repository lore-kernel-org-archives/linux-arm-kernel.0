From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 18 May 2012 16:19:58 -0600
Subject: [GIT PULL] gpio/omap: fix fallout from last cleanup series
In-Reply-To: <87vcjtkuck.fsf@ti.com>
References: <87vcjtkuck.fsf@ti.com>
Message-ID: <CACxGe6tK+rvm-hYYOMjtOs=0xeNdQvP3wM900iPvEnZZo-3Lkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 4:16 PM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Grant,
>
> Here's the promised branch that fixes the fallout from the last cleanup
> series which introduced a few new bugs in the cleanup. :(
>
> I collected the acks/tested-bys from the list.

Merged,
thanks.

g.

>
> Thanks,
>
> Kevin
>
>
> The following changes since commit 1b1287032df3a69d3ef9a486b444f4ffcca50d01:
>
> ?gpio/omap: fix missing check in *_runtime_suspend() (2012-05-11 17:08:40 -0700)
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.5/fixes/gpio-2
>
> for you to fetch changes up to b3c64bc30af67ed328a8d919e41160942b870451:
>
> ?gpio/omap: (re)fix wakeups on level-triggered GPIOs (2012-05-18 07:05:06 -0700)
>
> ----------------------------------------------------------------
> Kevin Hilman (2):
> ? ? ?gpio/omap: fix broken context restore for non-OFF mode transitions
> ? ? ?gpio/omap: (re)fix wakeups on level-triggered GPIOs
>
> ?drivers/gpio/gpio-omap.c | ? ?9 ++++-----
> ?1 file changed, 4 insertions(+), 5 deletions(-)



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
