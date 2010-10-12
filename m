From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 12 Oct 2010 17:31:56 +0200
Subject: [PATCH v3] imx-esdhc: update devices registration
In-Reply-To: <4CB47BCF.3060709@eukrea.com>
References: <20101012130435.GN29673@pengutronix.de>
	<1286895505-9325-1-git-send-email-eric@eukrea.com>
	<20101012150815.GO29673@pengutronix.de>
	<4CB47BCF.3060709@eukrea.com>
Message-ID: <20101012153155.GE4470@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 12, 2010 at 05:16:31PM +0200, Eric B?nard wrote:
> Hi Uwe,
> 
> Le 12/10/2010 17:08, Uwe Kleine-K?nig a ?crit :
> >>+#define MX25_MMC_SDHC1_BASE_ADDR	0x53fb4000
> >>+#define MX25_MMC_SDHC2_BASE_ADDR	0x53fb8000
> >I wonder about the name in the reference manual.  Is it really MMC_SDHC
> >for all socs?  I always wonder what it the best here (if they are named
> >inconsitently there), have it equal over all SoCs or have it match the
> >respective reference manual?!
> >
> reference manual, section Memory Map :
> i.MX25 : eSDHC-x
> i.MX35 : eSDHCv2-x
> i.MX51 : ESDHC x
> 
> so the manual are not consistent ... "MMC_SDHC" seems easy to
> understand but of course we can have ESDHC, or SDHC or something
> else if you have a better name to suggest.

I'd go for ESDHC, that seems to be the common part in all refmans. (And
comparing it to the SDHC-spec, it is also not really a straightforward
SDHC anyway ;))

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101012/d2fe3d70/attachment.sig>
