From: cjb@laptop.org (Chris Ball)
Date: Wed, 9 Feb 2011 00:54:52 +0000
Subject: [PATCH] mmc: mmc_mxc: Allow selection only for the correct
	platforms
In-Reply-To: <F09210E57DF486449C294B7BFB86534713C019@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1295542979-10329-1-git-send-email-fabio.estevam@freescale.com>
	<20110121103517.GD9041@pengutronix.de>
	<F09210E57DF486449C294B7BFB86534713C019@039-SN1MPN1-003.039d.mgd.msft.net>
Message-ID: <20110209005452.GA23675@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Wed, Feb 09, 2011 at 12:40:51AM +0000, Estevam Fabio-R49496 wrote:
> On Thu, Jan 20, 2011 at 03:02:59PM -0200, Fabio Estevam wrote:
> > Currently MMC_MXC driver can be selected by all i.MX devices.
> > 
> > Restrict its use only for the appropriate processors.
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for the ping -- I've pushed this to mmc-next with Sascha's ACK now.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
