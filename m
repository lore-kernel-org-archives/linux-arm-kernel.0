From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Fri, 13 Dec 2013 08:38:44 +0100
Subject: [PATCH v6 01/15] usb: doc: phy-mxs: Add more compatible strings
In-Reply-To: <CAL411-rt=_O5qaO_=AHps-LgrNyGwLdFSoCHk2POEn_p-Sn5qg@mail.gmail.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-2-git-send-email-peter.chen@freescale.com>
 <20131213081545.0185d3cb@ipc1.ka-ro>
 <CAL411-rt=_O5qaO_=AHps-LgrNyGwLdFSoCHk2POEn_p-Sn5qg@mail.gmail.com>
Message-ID: <20131213083844.060ff5ef@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Peter Chen wrote:
> On Fri, Dec 13, 2013 at 3:15 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> > Hi,
> >
> > Peter Chen wrote:
> >> Add "fsl,imx6q-usbphy" for imx6dq and imx6dl, add
> >> "fsl,imx6sl-usbphy" for imx6sl.
> >>
> >> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> >> ---
> >>  Documentation/devicetree/bindings/usb/mxs-phy.txt |    3 ++-
> >>  1 files changed, 2 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/mxs-phy.txt b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> >> index 5835b27..d850e55 100644
> >> --- a/Documentation/devicetree/bindings/usb/mxs-phy.txt
> >> +++ b/Documentation/devicetree/bindings/usb/mxs-phy.txt
> >> @@ -1,7 +1,8 @@
> >>  * Freescale MXS USB Phy Device
> >>
> >>  Required properties:
> >> -- compatible: Should be "fsl,imx23-usbphy"
> >> +- compatible: "fsl,imx23-usbphy" for imx23 and imx28, "fsl,imx6q-usbphy"
> >> +for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl
> >>
> > indentation?
> >
> 
> How many characters? 2 or 8?
>
I would align the line with the first character in the previous line:
- compatible: "fsl,imx23-usbphy" for imx23 and imx28, "fsl,imx6q-usbphy"
  for imx6dq and imx6dl, "fsl,imx6sl-usbphy" for imx6sl


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
