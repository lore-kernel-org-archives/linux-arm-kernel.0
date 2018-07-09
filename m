From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Tue, 10 Jul 2018 00:07:53 +0200
Subject: [PATCH 0/3] pinctrl: meson-g12a: add pinctrl driver support
In-Reply-To: <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
References: <20180704224511.29350-1-yixun.lan@amlogic.com>
 <CACRpkdauMRnLpfiARG-BWkuJfArri68e9BYx56SCUxJaYWsYYA@mail.gmail.com>
Message-ID: <CAFBinCAVSGTWFzW6nikbnC+K9n5KRYjun9bnEp7YsKbGRHJorg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Jul 9, 2018 at 3:35 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jul 4, 2018 at 4:48 PM Yixun Lan <yixun.lan@amlogic.com> wrote:
> >
> > This patch series try to add pinctrl driver support for
> > the Meson-G12A SoC.
> >
> >
> > Yixun Lan (3):
> >   documentation: Add compatibles for Amlogic Meson G12A pin controllers
> >   dt-bindings: pinctrl: meson-g12a: document pin name
> >   pinctrl: meson-g12a: add pinctrl driver support
>
> Overall this looks good to me, could we get some review or ACKs
> from Beniamino, Martin and/or Carlo as an indication that everything
> seems all right before I apply the series?
I do not have any documentation for this hardware (I'm not even sure
if this is the successor to AXG/"the Audio SoCs" or rather a successor
of GXL or GXM/"the OTT/STB SoCs" - I assume it's their new OTT/STB
SoCs since G12A is mentioned here and it seems to have a GPU: [0])

I will try to have a look in the next few days and see if I can spot
anything obvious
not sure if Neil or Kevin have access to the documentation, so it'd be
great if they could give feedback as well


Regards
Martin


[0] http://openlinux.amlogic.com:8000/download/doc/Linux_BSP_Kernel4.9_Buildroot_OpenLinux_Release_Notes_V20180330.pdf
