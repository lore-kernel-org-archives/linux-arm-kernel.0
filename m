From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 17:40:56 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v4.10
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <20161118014056.GH8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 10:44:27AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.10.
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.10
> 
> for you to fetch changes up to 68cc085a4daaa32f7138de1e918331c05165a484:
> 
>   ARM: dts: r8a7794: remove Z clock (2016-11-04 10:36:47 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.10
> 
> Clean-Ups and Corrections:
> * Removed Z clock from r8a7794 SoC; it is not present in hardware
> * Use generic pinctrl properties in SDHI nodes in gose board
> * Correct W=1 dtc warnings on r8a7794 SoC
> * Correct DU reg property on r8a7779 SoC
> * Correct SCIFB reg properties to cover all registers
> 
> Enhancements:
> * Configure pinmuxing for the DU0 input clock on the Marzen board
> * Enable VIN 0 - 2 on r8a7793 SoC
> * Enable HDMI input on Koelsch and Lager boards
> * Enable SDHI1 on rskrza1 board
> * Add MMCIF nodes to r7s72100 SoC
> * Add MSIOF clocks to r8a7792 SoC
> * Enable UHS for SDHI 0 & 1 on koelsch and alt boards

Thanks, merged.


-Olof
