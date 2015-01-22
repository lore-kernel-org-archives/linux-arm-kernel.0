From: horms@verge.net.au (Simon Horman)
Date: Thu, 22 Jan 2015 10:03:03 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC sh73a0
 Multiplatform Updates for v3.20
In-Reply-To: <cover.1421716945.git.horms+renesas@verge.net.au>
References: <cover.1421716945.git.horms+renesas@verge.net.au>
Message-ID: <20150122010303.GC25991@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 10:27:32AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC sh73a0 multiplatform updates for v3.20.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-sh73a0-multiplatform-for-v3.20,
> which I have already sent a pull-request for.

As Olof has have asked for further work on the above I am withdrawing
this pull-request.

> My understanding from Geert Uytterhoeven is that the above dependency
> is required to avoid a lock-up.
> 
> 
> The following changes since commit 93c9f0228a3d0a14640f86b3e8aeaf3c9b449bb7:
> 
>   ARM: shmobile: kzm9g-reference: Remove board C code and DT file (2015-01-14 09:46:48 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-multiplatform2-for-v3.20
> 
> for you to fetch changes up to e42c8385cfec0579a103b365d61748f199bfe239:
> 
>   ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node (2015-01-17 09:36:35 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC sh73a0 Multiplatform Updates for v3.20
> 
> * Add Cortex-A9 TWD node
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
> 
>  arch/arm/boot/dts/sh73a0.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
