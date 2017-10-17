From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Tue, 17 Oct 2017 01:04:01 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggMDAvMTFdIEtBU2FuIGZvciBhcm0=?=
In-Reply-To: <CAK8P3a3OOMxsr0QM+Uukec4Uq4UxHnUYF6jozxbzwJisd7vOaA@mail.gmail.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <CAK8P3a3OOMxsr0QM+Uukec4Uq4UxHnUYF6jozxbzwJisd7vOaA@mail.gmail.com>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CA4D@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2017 07:57 PM, Abbott Liu wrote:
>Nice!
>
>When I build-tested KASAN on x86 and arm64, I ran into a lot of build-time
>regressions (mostly warnings but also some errors), so I'd like to give it
>a spin in my randconfig tree before this gets merged. Can you point me
>to a git URL that I can pull into my testing tree?
>
>I could of course apply the patches from email, but I expect that there
>will be updated versions of the series, so it's easier if I can just pull
>the latest version.
>
>      Arnd

I'm sorry. I don't have git server. These patches base on:
1. git remote -v
origin  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (fetch)
origin  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git (push)

2. the commit is:
commit 46c1e79fee417f151547aa46fae04ab06cb666f4
Merge: ec846ec b130a69
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Sep 13 12:24:20 2017 -0700

    Merge branch 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip

    Pull perf fixes from Ingo Molnar:
     "A handful of tooling fixes"

    * 'perf-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip:
      perf stat: Wait for the correct child
      perf tools: Support running perf binaries with a dash in their name
      perf config: Check not only section->from_system_config but also item's
      perf ui progress: Fix progress update
      perf ui progress: Make sure we always define step value
      perf tools: Open perf.data with O_CLOEXEC flag
      tools lib api: Fix make DEBUG=1 build
      perf tests: Fix compile when libunwind's unwind.h is available
      tools include linux: Guard against redefinition of some macros
I'm sorry that I didn't base on a stabe version.

3. config: arch/arm/configs/vexpress_defconfig

4. gcc version: gcc version 6.1.0
