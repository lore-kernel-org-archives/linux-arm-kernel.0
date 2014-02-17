From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 17 Feb 2014 10:27:48 +0100
Subject: [PATCH v6] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <20140217012643.GA9879@S2101-09.ap.freescale.net>
References: <20140118083840.GD3430@S2101-09.ap.freescale.net>
 <1390220023-6423-1-git-send-email-mpa@pengutronix.de>
 <20140216220827.GC31006@pengutronix.de>
 <20140217012643.GA9879@S2101-09.ap.freescale.net>
Message-ID: <20140217092748.GA9197@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 09:26:45AM +0800, Shawn Guo wrote:
> On Sun, Feb 16, 2014 at 11:08:27PM +0100, Markus Pargmann wrote:
> > Hi Shawn,
> > 
> > On Mon, Jan 20, 2014 at 01:13:43PM +0100, Markus Pargmann wrote:
> > > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > > reconfiguration and needs this for correct interaction with SDMA. This
> > > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > > 
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > ---
> > > Hi Shawn,
> > > 
> > > Sorry for that last patch. I fixed it in this patch.
> > 
> > Ping. Should I send this again after rebasing it onto your latest branch?
> 
> I believe I've applied the v5 with a minor fix [1].  I split it into 2
> though, one for imx5 [2] and the other for imx6 [2], because I have to
> make my imx/dt pull request small to please arm-soc folks.

Oh thanks, I didn't notice that you applied v5 already.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140217/e892f742/attachment.sig>
