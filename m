From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 16:12:57 +0800
Subject: [PATCH v4 16/17] usb: phy-mxs: fix the problem by only using
 1st controller's register
In-Reply-To: <529D9781.1080209@pengutronix.de>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-17-git-send-email-peter.chen@freescale.com>
 <529D9781.1080209@pengutronix.de>
Message-ID: <20131203081256.GB19603@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 09:34:09AM +0100, Marc Kleine-Budde wrote:
> On 12/03/2013 08:37 AM, Peter Chen wrote:
> > We fix the problem that we only use the 1st controller's related
> > registers at mxs_phy_disconnect_line, but in fact, it needs to
> > access registers according to different PHYs.
> 
> Are you fixing the code that has been added in this series before? If
> so, please squash into the patch. Don't add the broken code in the first
> place.
> 

Thanks, will do squash

-- 

Best Regards,
Peter Chen
