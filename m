From: olof@lixom.net (Olof Johansson)
Date: Tue, 27 Mar 2012 17:56:08 -0700
Subject: [GIT PULL] ARM: tegra: Include assembler.h in sleep.S to fix
 build break
In-Reply-To: <4F709723.4080206@wwwdotorg.org>
References: <4F709723.4080206@wwwdotorg.org>
Message-ID: <CAOesGMiK3fLQP0oNZS0QwTM1+4uLs_QfAWbLXzH-=TWXSXbY7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 26, 2012 at 9:19 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> Arnd, Olof,
>
> This pull request depends on the merge of:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
> devel/io-cleanup
> (specifically 6f6f6a7 ARM: create a common IOMEM definition)
>
> and:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.4/soc
> (specifically c76fcc8 ARM: tegra: assembler code for LP3)
>
> and is based on a local branch that merges the two branches above.
>
> The following changes since commit 1ad105fc77e61f9dd7a272659a248e2979fdb893:
> ?Stephen Warren (1):
> ? ? ? ?Merge remote branch 'remotes/korg_olof_tegra/for-3.4/soc' into
> for-3.4/fixes-for-io-cleanup

Thanks, pulled into next/cleanup2 (after pulling in tegra/t30-smp into
the same).


-Olof
