From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:24:45 -0800
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v3.20
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
Message-ID: <20150112222445.GG22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 10:44:01AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v3.20.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v3.20
> 
> for you to fetch changes up to 7408d3061d2f04181820902fae6e92e4a73d5cc0:
> 
>   ARM: shmobile: r8a7791: add MLB+ clock (2014-12-23 09:18:23 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v3.20
> 
> * Use clock-indices instead of deprecated renesas,clock-indices
> * Prepare for r8a73a4 multiplatform support
> * Increase clock coverage for r8a779[014]
> * Correct r8a7779 clock usage
> * Correct LAN9220 VDDVARIO voltage on ape6evm
> * Correct QSPI SPI-Flash mode of lager and koelsch
> * Correct flash partition label and size on koelsch
> * Correct mask for GIC PPI interrupts on r8a779[14]
> * Correct BSC bus range on ape6evm-reference
> 

Thanks, merged into next/dt.


-Olof
