From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2018 17:42:55 +0200
Subject: [GIT PULL] Second Round of Renesas ARM64 Based SoC DT Updates for
 v4.20
In-Reply-To: <cover.1538125184.git.horms+renesas@verge.net.au>
References: <cover.1538125184.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a2jAPTr3HmbvJQCe+rq3MvhGoJbgcKUiE3ySL_BcA63Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2018 at 12:20 PM Simon Horman
<horms+renesas@verge.net.au> wrote:
>
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these second round of Renesas ARM64 based SoC DT updates for v4.20.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-arm64-dt-for-v4.20,
> which you have already pulled.
>
>
> The following changes since commit 450d6079e8d3c40c7ce67ac8bb4a2da9baf56613:
>
>   arm64: dts: r8a77965: add FDP1 device nodes (2018-09-13 09:48:13 +0200)
>
> are available in the git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-dt2-for-v4.20
>
> for you to fetch changes up to 158928f38e1c6f3ac4dd83cf2240ae412179005d:
>
>   arm64: dts: renesas: r8a77965: Add Sound and Audio DMAC device nodes (2018-09-26 12:31:04 +0200)
>
> ----------------------------------------------------------------
> Second Round of Renesas ARM64 Based SoC DT Updates for v4.20
>
> * Remove unneeded status from thermal nodes
>
> * R-Car Gen 3 SoCs:
>   - Use 400kHz for I2C DVFS bus
>   - Revise USB2.0 properties
> * R-Car Gen 3 SoC based ULCB boards: Add default bootargs
> * R-Car M3-N (r8a77965) SoC based boards: Enable audio with DMA
>
> * R-Car V3M (r8a77970 and V3H (r8a77980) SoCs:
>   - Add compare match timer (CMT) support
>   - Add timer pulse unit (TPU) support
> * R-Car V3H (r8a77980) and E3 (r8a77990) SoCs:
>   - Attach the SYS-DMAC to the IPMMU
> * E3 (r8a77990) SoC: Add display output support
> * R-Car E3 (r8a77990) based Ebisu board:
>   - Enable HDMI and CVBS input, and VGA and HDMI display output
>
> * R-Car D3 (r8a77995) SoC: Add LVDS support
> * R-Car D3 (r8a77995) based Draak board: Enable HDMI display output

Pulled into next/dt, thanks!

      Arnd
