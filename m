From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 4 Nov 2011 05:08:04 +0800
Subject: [GIT PULL] imx compile fixes
In-Reply-To: <20111103210444.GA2272@r65073-Latitude-D630>
References: <20111103210444.GA2272@r65073-Latitude-D630>
Message-ID: <CAJBJ56+O_vk4F3g41gGjbGhc0RKQ79wKqwNjw_JnNsMWw=YyYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot cc the list, sorry.

On Fri, Nov 4, 2011 at 5:04 AM, Shawn Guo <shawn.gsc@gmail.com> wrote:
> Hi Arnd,
>
> If you plan to send the last pull request today, please consider to
> take these patches, which are to fix imx compile errors seen on
> mainline. ?If you plan to do that tomorrow, you may probably want to
> wait for the pull request from Sascha.
>
> Hi Sascha,
>
> This should really be from you. ?But since today could be the last
> chance to get the patches to Arnd, I send them out there just in case
> tomorrow is too late, because I can not stand so many imx platforms
> having compile error on v3.2-rc1 for another week :)
>
> Regards,
> Shawn
>
> The following changes since commit 70c9f18ca8f3652c7dcf715e9f0d41c399fe130d:
>
> ?Merge branch 'next' of git://github.com/kernelslacker/cpufreq (2011-11-03 09:59:39 -0700)
>
> are available in the git repository at:
>
> ?git://git.linaro.org/people/shawnguo/linux-2.6.git imx/compile-fixes
>
> Jason Liu (2):
> ? ? ?ARM:i.MX: fix build error in tzic/avic.c
> ? ? ?ARM:i.MX: fix build error in clock-mx51-mx53.c
>
> Marc Zyngier (1):
> ? ? ?ARM: mxc: fix local timer interrupt handling
>
> ?arch/arm/mach-mx5/clock-mx51-mx53.c | ? ?2 ++
> ?arch/arm/plat-mxc/avic.c ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/plat-mxc/gic.c ? ? ? ? ? ? | ? 11 ++---------
> ?arch/arm/plat-mxc/tzic.c ? ? ? ? ? ?| ? ?1 +
> ?4 files changed, 6 insertions(+), 9 deletions(-)
>
