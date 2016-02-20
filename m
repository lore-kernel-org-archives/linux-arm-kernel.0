From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sat, 20 Feb 2016 18:21:33 +0100
Subject: [PATCH 3/4] ARM: dts: imx6ul: Add GPMI nand controller support
In-Reply-To: <CAOMZO5DTmG7Umt+H20r+tZi9zZhsK=eoPbHOBO3iwvM2GXXLgg@mail.gmail.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-4-git-send-email-michael@amarulasolutions.com>
 <CAOMZO5DTmG7Umt+H20r+tZi9zZhsK=eoPbHOBO3iwvM2GXXLgg@mail.gmail.com>
Message-ID: <20160220172127.GC24064@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sat, Feb 20, 2016 at 09:57:27AM -0200, Fabio Estevam wrote:
> Hi Michael,
> 
> On Sat, Feb 20, 2016 at 8:20 AM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> > Add support for GPMI nand controller.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> >  arch/arm/boot/dts/imx6ul.dtsi          | 33 +++++++++++++++++++++++++++++++++
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 10 ++++++++++
> >  drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  6 ++++--
> 
> It would be better to split the dts and mtd parts in two patches.

I'm thinking even to drop the IS_TYPE for the IMX6QUL. Does it make sense
to have or let compatible to the one that is already defined?

Michael

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
