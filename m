From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 14:02:53 -0800
Subject: [GIT PULL v2] Renesas ARM Based SoC DT Updates for v4.6
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <20160224220253.GQ10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 08:05:46PM +0100, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT updates for v4.6.
> 
> 
> Changes since v1 of this pull-request:
> * Drop two non-DT patches
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-for-v4.6
> 
> for you to fetch changes up to c3373b09ba0391bcd9e992b0a2ce52d48d33e47b:
> 
>   ARM: dts: silk: Enable SCIF_CLK frequency and pins (2016-02-09 19:43:28 +0100)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT Updates for v4.6
> 
> * Use SCIF and USBHS fallback compatibility strings
> * Add Baud Rate Generator (BRG) support for (H)SCIF
> * Enable SCIF_CLK frequency and pins
> * Use GIC_* defines
> * Enable audio on r8a7793/gose
> * Enable HDMI vidio out on r8a7793
> * Enable i2c on r8a7793/gose
> * Enable QSPI on alt
> * Enable GPIO keys and leds on gise
> * Enable audio on porter
> * Enable DU on porter

Merged, thanks.


-Olof
