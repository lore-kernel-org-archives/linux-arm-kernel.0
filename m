From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 10 Jun 2015 16:01:02 -0700
Subject: [GIT PULL] SoCFPGA updates for v4.2, part 2, version 2
In-Reply-To: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com> (dinh
 linux's message of "Fri, 5 Jun 2015 14:39:11 -0500")
References: <1433533151-6301-1-git-send-email-dinh.linux@gmail.com>
Message-ID: <7hh9qfjhht.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dinh.linux at gmail.com writes:

> Hi Arnd, Kevin, Olof,
>
> This is an updated pull request for the supend-to-ram patch that has the
> EDAC code removed in order to avoid a merge conflict.
>
> Thanks,
> Dinh
>
> The following changes since commit c65b99f046843d2455aa231747b5a07a999a9f3d:
>
>   Linux 4.1-rc6 (2015-05-31 19:01:07 -0700)

Why v4.1-rc6?  

Are there specific dependencies there?  If not, we prefer these pulls to
be on older -rc tags (typically nothing past where arm-soc/master is).

If there are no deps, could you respin this against -rc2/-rc3, or you
could also rebase on top of your previous socfpga_updates_for_v4.2 as
well (which itself is based on -rc2.)

Kevin
