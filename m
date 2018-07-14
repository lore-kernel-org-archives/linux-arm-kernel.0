From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 14 Jul 2018 16:36:15 +0200
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
 <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
Message-ID: <CAFBinCDqHEh_9Gt65FHgt-4e8o1T-YZqp9_kqS1ajqqxJ1qfuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 12:07 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Linus,
>
> On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> > On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
> > >
> > > This patch series try to add pinctrl driver support for
> > > the Meson-G12A SoC.
> > >
> > >
> > > Yixun Lan (3):
> > >   documentation: Add compatibles for Amlogic Meson G12A pin controllers
> > >   dt-bindings: pinctrl: meson-g12a: document pin name
> > >   pinctrl: meson-g12a: add pinctrl driver support
> >
> > Overall this looks good to me, could we get some review or ACKs
> > from Beniamino, Martin and/or Carlo as an indication that everything
> > seems all right before I apply the series?
> I do not have any documentation for this hardware (I'm not even sure
> if this is the successor to AXG/"the Audio SoCs" or rather a successor
> of GXL or GXM/"the OTT/STB SoCs"
for those who are interested: according to [0] the marketing name of
this SoC will be "A311D" - specs from the linked PDF:
- CPU: Quad Cortex-A73 + Dual Cortex-A53 (max frequency: TBD)
- GPU: ARM G52 MP4 (4ppc)
- Memory: DDR3/4 LPDDR3/4
- Video decoding: 4K H265&VP9&AVS2
- Video Encoding: 1080P H264 H265
- HDMI-Tx: 4K2K
- Ethernet: 10/100M/1000M
- AV output: CVBS
- IP License: Dolby, DTS

W400 is the reference board for this SoC, it comes with:
- EMMC
- WIFI AP6398S
- DDR 2GB

if I had to guess then I would say it's the successor of the GXL (or
GXM?) family


Regards
Martin


[0] http://openlinux.amlogic.com:8000/download/doc/Amlogic_A311D_Buildroot_Preview_Release_Notes_V20180706.pdf
