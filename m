From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Tue, 23 Jul 2013 10:09:40 +0200
Subject: [PATCH 2/2] ARM: dts: mx6: Add support for imx6dl nitrogen board
In-Reply-To: <CAOMZO5C8Zz27KQOQxnurRmEUqUPw6VZNPGc3g4oXEUZUDxtYVQ@mail.gmail.com>
References: <1374118960-19060-1-git-send-email-festevam@gmail.com>
 <1374118960-19060-2-git-send-email-festevam@gmail.com>
 <20130722075736.GC20271@S2101-09.ap.freescale.net>
 <CAOMZO5C8Zz27KQOQxnurRmEUqUPw6VZNPGc3g4oXEUZUDxtYVQ@mail.gmail.com>
Message-ID: <20974.14916.259380.424120@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Fabio Estevam writes:
> Hi Shawn,
> 
> On Mon, Jul 22, 2013 at 4:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> >> +/ {
> >> +     model = "Boundary Devices i.MX6 Dual Lite Nitrogen Board";
> >> +     compatible = "boundary,imx6dl-nitrogen", "fsl,imx6dl";
> >> +
> >> +     memory {
> >> +             reg = <0x10000000 0x40000000>;
> >> +     };
> >
> > This memory configuration is also common, right?
> 
> The reason I put the memory configuration in this file is because we
> also have nitrogen quad and dual-lite versions with 2GB.
> 
U-Boot is able to fill in these according to the actual amount of
memory detected.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
