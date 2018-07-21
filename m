From: olof@lixom.net (Olof Johansson)
Date: Sat, 21 Jul 2018 14:52:24 -0700
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.19 (redo)
In-Reply-To: <7ha7ql6goi.fsf@baylibre.com>
References: <7ha7ql6goi.fsf@baylibre.com>
Message-ID: <20180721215224.oa2rqhg2zexgo7uq@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 11:00:13AM -0500, Kevin Hilman wrote:
> Olof,
> 
> Here's the re-do of the pull that was missing Signed-off-by tags,
> pointed out by Stephen Rothwell.
> 
> Kevin
> 
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-1
> 
> for you to fetch changes up to 89803e8b26569bdf5798f8745a4c708bf9360ee6:
> 
>   ARM64: dts: meson-axg: add pdm pins (2018-07-20 08:18:37 -0700)
> 
> ----------------------------------------------------------------
> Amlogic 64-bit DT updates for v4.19
> - new SoC: S805x
> - new board: S805x-based P241 board from Amlogic
> - AXG: add ADC support w/buttons, add pins for PDM, SPDIF
> - AXG: s400 board: preliminary support for audio
> - GX: nanopi-k2: add HDMI, CEC, CVBS support
> 
> ----------------------------------------------------------------
> Jerome Brunet (9):
>       ARM64: dts: meson-axg: add s400 microphone card leds
>       ARM64: dts: meson-axg: add s400 main 12v supply
>       ARM64: dts: meson-axg: add s400 speaker amplifier
>       ARM64: dts: meson-axg: add spdif output pins
>       ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
>       ARM64: dts: meson-axg: add adc buttons the S400
>       ARM64: dts: meson-axg: remove spdif out from gpio a7
>       ARM64: dts: meson-axg: add spdif input pins
>       ARM64: dts: meson-axg: add pdm pins

I've started being a little grumpy with others to keep it consistent, and
you're consistent internally but not against other platforms: We use "arm64" or
ARM" as prefixes, not ARM64/arm.

I think it's time for a checkpatch rule for this, it's a bit silly to have to
point it out all the time since people seem to get it wrong so often.

I'll merge this for now and look at adding the rules.



-Olof
