From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 22 Aug 2014 16:11:48 +0800
Subject: [PATCH v2] ARM: i.MX: dts: Add support for the Freescale i.MX1
 ADS board
In-Reply-To: <1408461752.186151416@f405.i.mail.ru>
References: <1408430027-4326-1-git-send-email-shc_work@mail.ru>
 <CAOMZO5B7oiy0Kuac2wMSMNBAVima+S0OR1rR-9p034S75rBzjg@mail.gmail.com>
 <1408461752.186151416@f405.i.mail.ru>
Message-ID: <20140822081147.GE2540@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 07:22:32PM +0400, Alexander Shiyan wrote:
> Tue, 19 Aug 2014 10:29:08 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> > On Tue, Aug 19, 2014 at 3:33 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> > > This patch adds support for the Freescale (Motorola) i.MX1 ADS board.
> > > This change is intended to further remove non-DT support for this board.
> > >
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > 
> > Looks good, only one minor comment:
> > 
> > >
> > > +&iomuxc {
> > > +       imx1-motorola-ads {
> > 
> > Should be imx1-ads instead.
> 
> Ah, yes. Shawn, can this be fixed during apply?

Fixed and applied, thanks.
