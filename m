From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 19 Jul 2011 10:10:27 +0200
Subject: [PATCH v3 0/4] Add device tree probe for sdhci-esdhc-imx
In-Reply-To: <m262mzavhb.fsf@bob.laptop.org>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
	<m2pqljje3w.fsf@bob.laptop.org>
	<20110710013708.GA14492@S2100-06.ap.freescale.net>
	<m262mzavhb.fsf@bob.laptop.org>
Message-ID: <20110719081027.GM20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 09:51:28PM -0400, Chris Ball wrote:
> Hi Shawn, Sascha,
> 
> On Sat, Jul 09 2011, Shawn Guo wrote:
> >> > Shawn Guo (4):
> >> >       mmc: sdhci-esdhc-imx: do not reference platform data after probe
> >> >       mmc: sdhci-esdhc-imx: get rid of the uses of cpu_is_mx()
> >> >       mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
> >> >       mmc: sdhci-esdhc-imx: add device tree probe support
> >> 
> >> These don't apply against mmc-next -- what is your tree based on?
> >> 
> > It's based on linux-next with following patch applied.
> >
> > [PATCH v4 4/4] mmc: sdhci-esdhc-imx: extend card_detect and
> > write_protect support for mx5
> > http://permalink.gmane.org/gmane.linux.kernel.mmc/8748
> >
> > You applied the 3 of 4 patches in that series, and expect Sascha to
> > send this one through his tree after you send those 3.

Shawn, please ping me once all dependencies have been merged. I have no
influence when my patches get merged since my patches go via Arnd.

> 
> I see.  In that case, either Sascha can send this new series with my:
> 
> Acked-by: Chris Ball <cjb@laptop.org>
> 
> or I'll send it as a second pull request after Sascha sends [4/4].
> 
> Thanks,
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
