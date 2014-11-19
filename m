From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Nov 2014 22:47:03 +0100
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.19
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
Message-ID: <201411192247.03849.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 November 2014, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v3.19.
> 
> 
> This pull request is based on a merge of:
> 
> * "Renesas ARM Based SoC DT DU Updates for v3.19",
>   tagged as renesas-dt-du-for-v3.19.
> 
> * "Renesas ARM Based SoC r8a73a4 DT Timers Updates for v3.19",
>   tagged as renesas-r8a73a4-dt-timers-for-v3.19.
> 
> Both of which I have also sent a pull-request for.
> 
> 
> The following changes since commit 4df49d9e1f2592338b5e8d0b5ce9f2485e295cc0:
> 
>   Merge tag 'renesas-r8a73a4-dt-timers-for-v3.19' into dt-for-v3.19.base (2014-10-30 09:54:13 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.19
> 
> for you to fetch changes up to 25af9c83151822eb6d413b4d15d5f89804606ac7:
> 
>   ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property (2014-10-30 10:01:37 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v3.19
> 
> * Add Add SoC-specific SATA compatible property to r8a7779
> * Enable DMA for MMCIF on r8a7791 and r8a7790
> * Enable USB-PHY, HS-USB and USB3.0 on r8a7791 and r8a7790
> * Enable TMU timer via DT on r8a7778
> * Enable CMT timer via DT on r8a73a4
> * Add MMP and {SR}GX clocks to  r8a7791 and r8a7790
> * Correct scifa2 clock index on r8a7740
> * Add missing INTCA for irqpin on r8a7740

Pulled into next/dt, thanks!

	Arnd
