From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jan 2015 11:05:24 +0900
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 DT PM Updates for v3.20
In-Reply-To: <cover.1421716413.git.horms+renesas@verge.net.au>
References: <cover.1421716413.git.horms+renesas@verge.net.au>
Message-ID: <20150122020524.GA30863@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:27:43AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC sh73a0 DT PM updates for v3.20.
> 
> This pull request is based on a merge of:
> 
> * "[GIT PULL] Third Round of Renesas ARM Based SoC Updates for v3.20",
>   tagged as renesas-soc3-for-v3.20, which I have sent a pull request for.
> 
> * "[GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v3.20",
>   tagged as renesas-dt2-for-v3.20, which I have sent a pull request for.
> 
> My understanding from to Geert Uytterhoeven both of the above are required
> in order for the system to remain bootable.

There is also a dependency, which I apologise for not documenting,
on "ARM Based SoC Sh73a0 Multiplatform Updates for v3.20",
tagged as renesas-sh73a0-multiplatform-for-v3.20.

As Olof has have asked for further work on that pull-request I am withdrawing
this pull-request.

> 
> 
> The following changes since commit 2e828caaf311b5990c652e281d0ffceea382ae16:
> 
>   Merge branch 'dt-for-v3.20' into sh73a0-dt-pm-for-v3.20.base (2015-01-16 11:07:31 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-dt-pm-for-v3.20
> 
> for you to fetch changes up to 61837def3c23ba2ac662fd26c77979e072deb2e0:
> 
>   ARM: shmobile: sh73a0 dtsi: Add PM domain support (2015-01-16 11:07:59 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC sh73a0 DT PM Updates for v3.20
> 
> Add PM domain support to sh73a0
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: sh73a0 dtsi: Add PM domain support
> 
>  arch/arm/boot/dts/sh73a0.dtsi | 144 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 2 deletions(-)
> 
