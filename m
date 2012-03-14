From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 14 Mar 2012 18:41:51 +0200
Subject: [GIT PULL] cpufreq: OMAP updates for v3.4
In-Reply-To: <87y5rci2na.fsf@ti.com>
References: <87y5rci2na.fsf@ti.com>
Message-ID: <CANOLnON91vXWb2L-FXjz3sqq-9j5SaEodtpt_yvFiN33D4Q3Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 10:20 PM, Kevin Hilman <khilman@ti.com> wrote:
> Dave,
>
> Please pull the following OMAP CPUfreq driver changes for v3.4.
>
> Thanks,
>
> Kevin
>
>
>
> The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:
>
> ?Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)
>
> are available in the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/cpufreq
>
> for you to fetch changes up to 42daffd2d6c665716d442d518022ecaad17ddf64:
>
> ?cpufreq: OMAP: specify range for voltage scaling (2012-03-02 13:55:57 -0800)
>
> ----------------------------------------------------------------
> Afzal Mohammed (1):
> ? ? ?cpufreq: OMAP: specify range for voltage scaling
>
> Kevin Hilman (1):
> ? ? ?cpufreq: OMAP: scale voltage along with frequency
>
> Russell King (1):
> ? ? ?cpufreq: OMAP driver depends CPUfreq tables

It seems this one got messed up, it says "default ARCH_OMAP2PLUS"
instead of depends.
Can it be dropped and resent, or do we need a fixup patch?

-- 
Gra?vydas
