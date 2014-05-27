From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 27 May 2014 08:21:24 +0200
Subject: [PATCH v4 08/17] ASoC: fsl-ssi: introduce SoC specific data
In-Reply-To: <20140520220213.GZ12304@sirena.org.uk>
References: <1398682498-24357-1-git-send-email-mpa@pengutronix.de>
 <1398682498-24357-9-git-send-email-mpa@pengutronix.de>
 <20140520220213.GZ12304@sirena.org.uk>
Message-ID: <20140527062124.GB20989@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 20, 2014 at 11:02:13PM +0100, Mark Brown wrote:
> On Mon, Apr 28, 2014 at 12:54:49PM +0200, Markus Pargmann wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Introduce a SoC data struct which contains the differences between
> > the different SoCs this driver supports. This makes it easy to support
> > more differences without having to introduce a new switch/case each
> > time.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> 
> Applied everything before this patch, thanks.  I've not applied this one
> since you didn't sign it off - please make sure when forwarding patches
> for other people that you add your signoff at the bottom, this is needed
> for legal reasons (see SubmittingPatches).

Ok, thanks, I will resubmit the remaining patches.

Best Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/c72bd2b1/attachment.sig>
