From: olof@lixom.net (Olof Johansson)
Date: Fri, 6 Feb 2015 00:33:41 -0800
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.20 (round 3)
In-Reply-To: <54D0ECF2.9050104@free-electrons.com>
References: <54D0ECF2.9050104@free-electrons.com>
Message-ID: <20150206083341.GI23582@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 03, 2015 at 04:44:50PM +0100, Gregory CLEMENT wrote:
> Hi Olof, Arnd,
> 
> This is the third incremental pull request for mvebu/dt. I now it
> comes very late, but as explained in my email series it should not
> introduce any regression as all the change are made inside the comment
> blocks, so for the stability it should be safe to take them.
> 
> My main motivation for having this series merged in 3.20 is to avoid
> asking each author of the dts(i) patches if he agrees with the dual
> license during the next cycle. At the end it is not something
> essential but it will make our life easier.
> 
> Thanks,
> 
> Gregory
> 
> The following changes since commit 6cc082a84e13f3a0078973a08adf22f1404acc3d:
> 
>   ARM: mvebu: make DTS comments reflect DEBUG_LL changes (2015-01-21 18:36:14 -0600)
> 
> are available in the git repository at:
> 
>   ssh://git.infradead.org/srv/git/linux-mvebu.git tags/mvebu-dt-3.20-3
> 
> for you to fetch changes up to 3c21b5fa897ae4b594d6b76a4572741fea7824b7:
> 
>   ARM: mvebu: armada-xp-synology-ds414: Relicense the device tree under GPLv2+/X11 (2015-01-26 19:28:13 -0600)
> 
> ----------------------------------------------------------------
> Relicense all Armada dts{i} files under dual license of GPLv2+ and
> X11. This should make it easier to reuse these files with other
> operating systems and boot loaders.

Thanks, merged!


-Olof
