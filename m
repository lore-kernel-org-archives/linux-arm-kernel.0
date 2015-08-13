From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 12:09:38 +0200
Subject: [GIT PULL] at91: defconfig for 4.3 #2
In-Reply-To: <20150807162754.GA20169@piout.net>
References: <20150807162754.GA20169@piout.net>
Message-ID: <20150813100938.GN30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 06:27:54PM +0200, Alexandre Belloni wrote:
> Arnd, Olof, Kevin,
> 
> A little defconfig update. That will probably be all for this cycle.
> 
> Thanks, bye,
> 
> 
> The following changes since commit eff7f41572a645bf14a96a6f844be4f1c88cd9dd:
> 
>   ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support (2015-07-30 14:17:31 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-defconfig2
> 
> for you to fetch changes up to ea7bf603fd494391acc1f42acbfc34260b965c44:
> 
>   ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER (2015-08-07 12:07:50 +0200)

Nicolas had sent me one patch which you've also included here but it's not in
the pull request ("enable ISI and ov2640 support"). That caused a conflict
here, so to avoid having the patch in the tree twice I instead also directly
applied your patches from this branch instead of merging.

Sorry about that, it started due to Nicolas sending the discrete patch to us.
So it seems like we'll apply at91 defconfig updates directly this release, in
case there are any more. No big deal I hope. :)


-Olof
