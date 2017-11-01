From: vanessa.maegima@nxp.com (Vanessa Maegima)
Date: Wed, 1 Nov 2017 12:38:44 +0000
Subject: [PATCH v2] ARM: dts: imx7d-pico: Add Wifi support
In-Reply-To: <CAP9ODKrp1+-u+OvuXLv_k7rpo-5Y6DpoxHFA+2zXM=XbPA7GBQ@mail.gmail.com>
References: <1503056221-29183-1-git-send-email-vanessa.maegima@nxp.com>
 <CAP9ODKrp1+-u+OvuXLv_k7rpo-5Y6DpoxHFA+2zXM=XbPA7GBQ@mail.gmail.com>
Message-ID: <1509539876.4068.2.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Otavio,

On Ter, 2017-10-31 at 16:11 -0200, Otavio Salvador wrote:
> On Fri, Aug 18, 2017 at 8:37 AM, Vanessa Maegima
> <vanessa.maegima@nxp.com> wrote:
> > 
> > imx7d-pico has an ap6212 wifi chip connected to usdhc2 port.
> > 
> > Add support for the usdhc2 port and to the WL_REG_ON regulator
> > so Wifi can be functional on this board.
> > 
> > Signed-off-by: Vanessa Maegima <vanessa.maegima@nxp.com>
> It seems the name of the dtb is misleading ... this dtb refers mostly
> to the imx7d-pico-pi board no?
> 

Yes, this refers to the imx7d-pico-pi board. At the time I added this
support, I was not aware of the board variants as I had only the pico-
pi baseboard. I can work to separate this dts into SoM and baseboard
dts if you think this would be better, but I can only support pico-pi
as I do not have access to the other baseboards.

Best,
Vanessa
