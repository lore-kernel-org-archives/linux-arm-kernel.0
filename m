From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 May 2016 09:21:25 +0900
Subject: [GIT PULL] Renesas ARM64 Based SoC DT PM Domain Updates for v4.7
In-Reply-To: <cover.1461730364.git.horms+renesas@verge.net.au>
References: <cover.1461730364.git.horms+renesas@verge.net.au>
Message-ID: <20160506002125.GE24999@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 27, 2016 at 02:20:10PM +1000, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC DT PM Domain updates for v4.7.
> 
> This pull requests is based on a merge of:
> 
> * "[GIT PULL] Second Round of Renesas ARM Based SoC R-Car SYSC Updates for
>   v4.7", tagged as renesas-rcar-sysc2-for-v4.7, which you have already
>   pulled
> * "[GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for v4.7",
>   tagged as renesas-arm64-dt2-for-v4.7, which I have sent a pull request
>   for.
> 
> The reason for the somewhat tedious base on
> renesas-rcar-sysc2-for-v4.7, which provides driver changes,
> is a hard run-time dependency.
> 
> I also have a similar set of changes for ARM (32-bit) which I will send
> separately.

I am wondering if this pull-request might have slipped through the cracks.

FWIW, all other pull requests I have submitted for v4.7 have been pulled
(thanks!) including a similar pull-request for ARM (32-bit) which is
present in the next/late branch of the arm-soc tree.

I do not plan to send any more non-fix pull requests for v4.7.
And at this stage I am not aware of any fixes for v4.7.

> The following changes since commit 3238ec7c0a821915f38095752de97a424fd1d6ce:
> 
>   Merge tag 'renesas-rcar-sysc2-for-v4.7' into arm64-dt-pm-domain-for-v4.7 (2016-04-27 11:49:19 +1000)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-pm-domain-for-v4.7
> 
> for you to fetch changes up to 38dbb45ee4bc7dda4aabba2178eebff2f93380d1:
> 
>   arm64: dts: r8a7795: Use SYSC "always-on" PM Domain (2016-04-27 14:10:41 +1000)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT PM Domain Updates for v4.7
> 
> * Add SYSC PM Domains to DT of r8a7795 SoC
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (2):
>       arm64: dts: r8a7795: Add SYSC PM Domains
>       arm64: dts: r8a7795: Use SYSC "always-on" PM Domain
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 123 +++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 55 deletions(-)
> 
