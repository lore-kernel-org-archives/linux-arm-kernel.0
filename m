From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:20:41 -0700
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.12
In-Reply-To: <cover.1491578743.git.horms+renesas@verge.net.au>
References: <cover.1491578743.git.horms+renesas@verge.net.au>
Message-ID: <20170419132041.GF29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 11:57:59AM -0400, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates
> for v4.12.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.12,
> which you have already pulled.
> 
> 
> The following changes since commit 3cbe33367d4fd480a92fbc131a96fa925be9e95d:
> 
>   arm64: dts: r8a7796: salvator-x: Drop superfluous status update for frequency override (2017-03-13 10:21:16 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.12
> 
> for you to fetch changes up to 6922bd71adab0a7fe8ffbdc3e72a46431fa29656:
> 
>   arm64: dts: r8a7795: salvator-x: Drop _clk suffix from X12 clock node name (2017-04-05 14:17:19 -0400)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.12
> 
> Corrections:
> * r8a7795: Correct SATA device size to 2MiB for r8a7795 SoC
> 
> Cleanup:
> * Drop _clk suffix from X12 clock node name for r8a7795 SoC
> 
> Enhancements:
> * Add reset control properties for r8a779[56]
> 

Merged, thanks.


-Olof
