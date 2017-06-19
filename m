From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 22:51:07 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Bindings
 Updates for v4.13
In-Reply-To: <cover.1497617896.git.horms+renesas@verge.net.au>
References: <cover.1497617896.git.horms+renesas@verge.net.au>
Message-ID: <20170619055107.GK7703@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 16, 2017 at 03:30:57PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these second round of Renesas ARM based SoC DT bindings
> updates for v4.13.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-dt-bindings-for-v4.13,
> which I you have already pulled.
> 
> 
> The following changes since commit 40c9bbea140e64a4257b794969e759c2c481c399:
> 
>   ARM: dts: r7s72100: add USB bit definitions (2017-05-15 09:02:37 +0200)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings2-for-v4.13
> 
> for you to fetch changes up to 521ec12e2f56b16e6a0b4e7ef97a666bd3de4ff5:
> 
>   ARM: shmobile: Document Renesas H3-based Salvator-XS board DT bindings (2017-06-12 11:59:07 +0200)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC DT Bindings Updates for v4.13
> 
> * Document:
>   - Add Renesas H3-based Salvator-XS board DT bindings
>   - Add iW-RainboW-G20D-Qseven-RZG1M board
>   - Add iW-RainboW-G20M-Qseven-RZG1M system on module
>   - Update R-Car Gen3 ULCB board part numbers
> * Add clock bit definitions for r7s72100 SoC
> 
> ----------------------------------------------------------------
> Biju Das (2):
>       ARM: shmobile: document iW-RainboW-G20M-Qseven-RZG1M system on module
>       ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M board
> 
> Chris Brandt (1):
>       ARM: dts: r7s72100: add clock bit definitions
> 
> Geert Uytterhoeven (2):
>       ARM: shmobile: Update R-Car Gen3 ULCB board part numbers
>       ARM: shmobile: Document Renesas H3-based Salvator-XS board DT bindings

Merged, thanks.


-Olof
