From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jun 2016 15:38:21 -0700
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.8
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <20160613223821.GC29879@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:59:59AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.8.
> 
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.8
> 
> for you to fetch changes up to b6960f19676e19f37a5e5a8af059fdf3b435d2f4:
> 
>   ARM: dts: silk: Fix W=1 dtc warnings (2016-05-30 09:37:13 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.8
> 
> * Fix W=1 dtc warnings
> * Reverence both DMA controllers on R-Car Gen 2 SoCs
> * Remove nonexistent thermal sensor clock from r8a7794 SoC
> * Correct unit names for cpu nodes on r8a7790 SoC
> * Add MMCIF0 to r8a7793 SoC
> * RTS/CTS hardware flow control for kzm9g and bockw boards
> 

Merged, thanks.


-Olof
