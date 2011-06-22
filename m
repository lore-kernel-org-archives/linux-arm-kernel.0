From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 22 Jun 2011 10:53:36 +0800
Subject: [PATCH 6/6] ARM: mxc: clean up imx-dma device registration
In-Reply-To: <20110621225758.GG6069@pengutronix.de>
References: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
	<1307950645-26529-7-git-send-email-shawn.guo@linaro.org>
	<20110620145054.GA24184@S2100-06.ap.freescale.net>
	<20110621225758.GG6069@pengutronix.de>
Message-ID: <20110622025336.GC25234@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 12:57:58AM +0200, Sascha Hauer wrote:
> On Mon, Jun 20, 2011 at 10:50:55PM +0800, Shawn Guo wrote:
> > Hi Sascha,
> > 
> > Any comment on this one?
> >
> 
> Please respin this series on the for-next branch. Fabio has
> added i.MX53 support in the meantime and this does not apply anymore.
> 
This is exactly the thing I feel strange about.  I sent the patch
trying to stop people adding more churn there.  However, you applied
the patch adding more churn yesterday, and are asking me to rebase
this cleanup patch set today.  IMO, the cleanup patch should be
applied first, and the i.MX53 patch should be asked to respin.

But no problem, I will do.

-- 
Regards,
Shawn
