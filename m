From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 12:52:08 -0800
Subject: [GIT PULL] Third Round of Renesas ARM64 Based SoC DT Updates for
 v4.5
In-Reply-To: <cover.1450401186.git.horms+renesas@verge.net.au>
References: <cover.1450401186.git.horms+renesas@verge.net.au>
Message-ID: <20151222205208.GQ30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:29:14AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these third round of Renesas ARM64 based SoC DT updates
> for v4.5.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt2-for-v4.5,
> which you have already pulled.
> 
> 
> The following changes since commit 672b79312c04016481a11d4b996b4512207ffbd3:
> 
>   arm64: renesas: salvator-x: Sound DVC support (2015-11-26 11:31:43 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt3-for-v4.5

Merged, but:

>       arm64: dts: r8a7795: Add PSCI node
>       arm64: dts: r8a7795: Add Cortex-A57 CPU cores
>       arm64: renesas: salvator-x: Add board part number to DT bindings
>       arm64: dts: r8a7795: Add SATA controller node
>       arm64: dts: salvator-x: Enable SATA controller
>       arm64: renesas: salvator-x: set ak4613 In/Out pin as single-end
>       arm64: renesas: salvator-x: use CS2000 as AUDIO_CLK_B
>       arm64: renesas: r8a7795: fix SATA clock assignment
>       arm64: renesas: r8a7795: add internal delay for i2c IPs
>       arm64: dts: r8a7795: Add pmu device nodes

Please me more consistent in patch description prefixes.


-Olof
