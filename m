From: olof@lixom.net (Olof Johansson)
Date: Fri, 17 Jul 2015 09:59:57 -0700
Subject: [PULL] ARM: clockevents: Migrate to 'set-state' callbacks
In-Reply-To: <cover.1437101996.git.viresh.kumar@linaro.org>
References: <cover.1437101996.git.viresh.kumar@linaro.org>
Message-ID: <20150717165957.GC21691@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 10:40:54AM +0530, Viresh Kumar wrote:
> Hi Olof,
> 
> This series migrates ARM clockevent drivers (present in arch/arm/
> directory), to the new set-state interface. This would enable these
> drivers to use new states (like: ONESHOT_STOPPED, etc.) of a clockevent
> device (if required), as the set-mode interface is marked obsolete now
> and wouldn't be expanded to handle new states.
> 
> --
> viresh
> 
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git ARM/clkevt/set-state-4.3

Merged into next/cleanup. Please consider using signed tags in the future
instead of plain branches.


-Olof
