From: olof@lixom.net (Olof Johansson)
Date: Mon, 13 Jun 2016 15:29:26 -0700
Subject: [GIT PULL] Renesas ARM64 Based SoC DT Updates for v4.8
In-Reply-To: <cover.1465347183.git.horms+renesas@verge.net.au>
References: <cover.1465347183.git.horms+renesas@verge.net.au>
Message-ID: <20160613222926.GB29879@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 08, 2016 at 09:59:42AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM64 based SoC DT updates for v4.8.
> 
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt-for-v4.8
> 
> for you to fetch changes up to 21cc405c8a6332ddad2d2751a9723b2b3e227a05:
> 
>   arm64: dts: r8a7795: Drop 0x from unit address of gic (2016-05-30 10:18:01 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM64 Based SoC DT Updates for v4.8
> 
> * Fix W=1 dtc warnings and other cleanups
> * Enable watchdog timer
> * Enable DMA for I2C
> * Increase the size of GIC-400 mapped registers: be nicer to hypervisors
> * Support RTS/CTS hardware flow control

Merged, thanks.


-Olof
