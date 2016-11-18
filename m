From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 17:41:51 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.10
In-Reply-To: <cover.1478251657.git.horms+renesas@verge.net.au>
References: <cover.1478251657.git.horms+renesas@verge.net.au>
Message-ID: <20161118014151.GI8578@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 10:44:42AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC updates for v4.10.
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.10
> 
> for you to fetch changes up to 9652623f8f019edc93a7a934a10b7d0b90421d5a:
> 
>   ARM: shmobile: r8a7779/marzen: Add board part number to DT bindings (2016-11-04 10:25:45 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v4.10
> 
> Enhancements:
> * Basic support for r8a7743 SoC; only SoC code so far
> * Select errata 798181 for SoCs with CA15 cores
> 
> Clean-up:
> * Consolidate R8A7743 and R8A779[234] machine definitions
> 
> Documentation:
> * Add Marzen, Gose and Alt board part numbers to DT bindings
> * Document SK-RZG1M board

Thanks, merged.


-Olof
