From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Jul 2011 14:59:33 +0200
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <20110713124648.GA6640@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<20110713124648.GA6640@opensource.wolfsonmicro.com>
Message-ID: <20110713125933.GH1928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 09:46:52PM +0900, Mark Brown wrote:
> On Wed, Jul 13, 2011 at 01:57:11PM +0200, Wolfram Sang wrote:
> 
> > Proper regulator support for mxs is not in mainline yet. Is that
> > planned? How do you do it?
> 
> Regulator support is not a feature of the platform, it's a generic Linux
> feature.

Yup, sorry, meant s/mxs/mx28evk/

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110713/8e742c20/attachment.sig>
