From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Jul 2018 12:02:00 +0200
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.19 (redo)
In-Reply-To: <20180721215224.oa2rqhg2zexgo7uq@localhost>
References: <7ha7ql6goi.fsf@baylibre.com>
 <20180721215224.oa2rqhg2zexgo7uq@localhost>
Message-ID: <1532340120.26720.94.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-07-21 at 14:52 -0700, Olof Johansson wrote:
> > ----------------------------------------------------------------
> > Amlogic 64-bit DT updates for v4.19
> > - new SoC: S805x
> > - new board: S805x-based P241 board from Amlogic
> > - AXG: add ADC support w/buttons, add pins for PDM, SPDIF
> > - AXG: s400 board: preliminary support for audio
> > - GX: nanopi-k2: add HDMI, CEC, CVBS support
> > 
> > ----------------------------------------------------------------
> > Jerome Brunet (9):
> >        ARM64: dts: meson-axg: add s400 microphone card leds
> >        ARM64: dts: meson-axg: add s400 main 12v supply
> >        ARM64: dts: meson-axg: add s400 speaker amplifier
> >        ARM64: dts: meson-axg: add spdif output pins
> >        ARM64: dts: meson-axg: remove vddio_ao18 from SoC dtsi
> >        ARM64: dts: meson-axg: add adc buttons the S400
> >        ARM64: dts: meson-axg: remove spdif out from gpio a7
> >        ARM64: dts: meson-axg: add spdif input pins
> >        ARM64: dts: meson-axg: add pdm pins
> 
> I've started being a little grumpy with others to keep it consistent, and
> you're consistent internally but not against other platforms: We use "arm64" or
> ARM" as prefixes, not ARM64/arm.
> 
> I think it's time for a checkpatch rule for this, it's a bit silly to have to
> point it out all the time since people seem to get it wrong so often.
> 
> I'll merge this for now and look at adding the rules.

Hi Olof,

Just to be clear, from now on, you request that we use 'arm64' as prefix,
instead of 'ARM64' ? 

And we should continue with 'ARM' for the 32bits arch (and not 'arm'), right ?

Best Regards
Jerome
