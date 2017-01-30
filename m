From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 20:54:50 -0800
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for
 v4.11
In-Reply-To: <cover.1485425227.git.horms+renesas@verge.net.au>
References: <cover.1485425227.git.horms+renesas@verge.net.au>
Message-ID: <20170130045450.GA18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 11:11:05AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT updates for v4.11.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt-for-v4.11,
> which you have already pulled.
> 
> 
> The following changes since commit 654450baf2afba86cf328e1849ccac61ec4630af:
> 
>   ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for msiof nodes (2017-01-03 10:47:05 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.11
> 
> for you to fetch changes up to 5786ac14239a0809ca13e6a6f77147e6bb04aa29:
> 
>   ARM: dts: r7s72100: add power-domains to mmcif (2017-01-25 11:32:02 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC DT Updates for v4.11
> 
> Enhancements:
> * Add power-domains to mmcif on r7s72100 SoC
> * Add OSTM to rskrza1/r7s72100
> * Link ARM GIC to clock and clock domain on r8a774[35] SoCs
> 
> Clean-up:
> * Correct SATA device status on r8a7779/marzen

Merged, thanks!


-Olof
