From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 11 Jun 2015 16:34:24 -0700
Subject: [GIT PULL 2/3] omap defconfig changes for v4.2
In-Reply-To: <556de668.8f9c6b0a.05a4.ffffe794SMTPIN_ADDED_BROKEN@mx.google.com>
 (Tony Lindgren's message of "Tue, 2 Jun 2015 10:22:16 -0700")
References: <556de668.8f9c6b0a.05a4.ffffe794SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <7hpp51bz0f.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:
>
>   Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/o2_dc
>
> for you to fetch changes up to 4cbb08336f506cde30c0dfb3e49c55a52842fb5c:
>
>   ARM: omap2plus_defconfig: Enable TOUCHSCREEN_PIXCIR (2015-06-02 07:54:50 -0700)
>
> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.2 merge window:
>
> - Enable dm9000 as built-in for NFSroot
>
> - Enable dm816x USB phy as a loadable module
>
> - Enable Pixcir touch screen as a loadable module
>
> ----------------------------------------------------------------

Pulled into next/defconfig.

Thanks,

Kevin
