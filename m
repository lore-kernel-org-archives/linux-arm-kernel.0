From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 25 Jul 2018 21:11:23 +0200
Subject: [PATCH 00/14] arm64: dts: meson-axg: add audio support
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jerome,

On Tue, Jul 24, 2018 at 2:53 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> The main purpose of this patchset is to add the audio devices on amlogic's
> AXG SoCs.
>
> Some codecs require some power supplies. This is why the 3 first patches
> deal with the S400 power supplies, even if some are not related to audio.
>
> In term of dependency, apart from the clock bindings you have already
> pulled for your second PR to arm-soc, this patchset requires the ARB
> reset bindings [0] for patch 5. I don't know if Philip can make it
> available somewhere ?
>
> Of course, if the dependencies make this patchset too complicated to
> merge in this cycle, I'll resubmit once the next rc1 is out.
>
> Jerome Brunet (14):
>   arm64: dts: meson-axg: improve power supplies description
>   arm64: dts: meson-axg: add vcc 5v regulator on the s400
>   arm64: dts: meson-axg: add usb power regulator
>   arm64: dts: meson-axg: add audio arb reset controller
>   arm64: dts: meson-axg: add audio fifos
>   arm64: dts: meson-axg: add spdifout
>   arm64: dts: meson-axg: add tdmin formatters
>   arm64: dts: meson-axg: add tdmout formatters
>   arm64: dts: meson-axg: add tdm interfaces
>   arm64: dts: meson-axg: add linein codec
>   arm64: dts: meson-axg: add lineout codec
>   arm64: dts: meson-axg: add spdif-dit codec
>   arm64: dts: meson-axg: s400: enable audio devices
>   arm64: dts: meson-axg: add s400 sound card
nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
while other patches that are touching the s400 board aren't
if you have to re-send this series: can you please use the "arm64:
dts: meson-axg: s400:" prefix for all patches touching the s400 board?


Thank you!
Regards
Martin
