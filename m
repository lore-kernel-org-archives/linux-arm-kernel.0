From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 15:41:43 -0700
Subject: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas
 ARM-based platforms
In-Reply-To: <201205112025.13478.rjw@sisk.pl>
References: <201205112025.13478.rjw@sisk.pl>
Message-ID: <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, May 11, 2012 at 11:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>
> ? ?Linux 3.4-rc6
>
> with top-most commit 5fab7b501bf29c08c5b01627b496b6b766bd0165
>
> ? ?ARM / mach-shmobile: Invalidate caches when booting secondary cores
>
> from the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes

No such branch (nor tag).

> to receive urgent fixes for Renesas ARM-based platforms. ?Four of these commits
> are fixes of regressions new in 3.4-rc and the last one is necessary for SMP to
> work on those systems in general.
[...]
> Guennadi Liakhovetski (2):
> ? ? ?ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
> ? ? ?ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper

These seem to fix the long-standing build errors on the two platforms,
but that's impossible to tell from reading the commit messages (they
are empty). Care to add one describing why they're important to go in?


Thanks!

-Olof
