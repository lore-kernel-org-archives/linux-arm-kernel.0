From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 May 2012 15:32:59 -0700
Subject: [GIT PULL][Update x2] Urgent fixes (for v3.4 if possible) for
 Renesas ARM-based platforms
In-Reply-To: <201205122309.53928.rjw@sisk.pl>
References: <201205112025.13478.rjw@sisk.pl> <201205122256.24289.rjw@sisk.pl>
 <201205122309.53928.rjw@sisk.pl>
Message-ID: <CAOesGMgULO=os=pp8J3aMQDWuWse308xBtEvfMRcTnSz+JHo7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

On Sat, May 12, 2012 at 2:09 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
>
> ? ?Linux 3.4-rc6
>
> with top-most commit e994d5eb7c3e45e13eb4fc882a47238f8dc4d63e
>
> ? ?ARM / mach-shmobile: Invalidate caches when booting secondary cores
>
> from the git repository at:
>
> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes
>
> to receive urgent fixes for Renesas ARM-based platforms. ?Four of these commits
> are fixes of regressions new in 3.4-rc and the last one is necessary for SMP to
> work on those systems in general.

Pulled! Thanks for the quick respin. I'll send them up shortly,
there's one other 3.4 fixes pull request that I'm waiting on a respin
for and off they will go.


-Olof
