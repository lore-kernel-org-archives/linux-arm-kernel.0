From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 20:57:38 -0800
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates
 for v4.11
In-Reply-To: <cover.1485508214.git.horms+renesas@verge.net.au>
References: <cover.1485508214.git.horms+renesas@verge.net.au>
Message-ID: <20170130045738.GD18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 10:14:27AM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM64 based SoC DT updates for v4.11.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.11,
> which you have already pulled.
> 
> 
> The following changes since commit b2b9443beee5017ebdb3f2be9ef472c73d260481:
> 
>   arm64: dts: r8a7795: Add PWM support (2017-01-04 10:00:44 +0100)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.11
> 
> for you to fetch changes up to 7e1c23b94ed7f0d2719795a9828402003de5335d:
> 
>   arm64: dts: r8a7796: Mark EthernetAVB device node disabled (2017-01-27 10:09:02 +0100)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.11
> 
> r8a779[56] SoCs:
> * Mark EthernetAVB device node disabled in DT for r8a779[56] SoCs
>   - They are enabled as appropriate in board DT files
> * Link ARM GIC to clock and clock domain on r8a779[56] SoCs
> * Add thermal support
> 
> r8a7795 SoC:
> * Tidyup audma definition order on r8a7795 SoC
> * Add missing power-domains property for SATA
> 
> r8a7795/h3ulcb board:
> * Add MIX/CTU support as per support present in DT for r8a7796

Merged, thanks!


-Olof
