From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 May 2014 14:30:55 +0200
Subject: [PATCH RESEND v4 4/8] phy: usb: sunxi: Introduce Allwinner A31
 USB PHY support
In-Reply-To: <53732BC9.3020507@ti.com>
References: <1399995862-17788-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399995862-17788-5-git-send-email-maxime.ripard@free-electrons.com>
 <53732BC9.3020507@ti.com>
Message-ID: <20140514123055.GJ29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 14, 2014 at 02:09:37PM +0530, Kishon Vijay Abraham I wrote:
> > @@ -305,6 +315,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
> >  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> >  	{ .compatible = "allwinner,sun4i-a10-usb-phy" },
> >  	{ .compatible = "allwinner,sun5i-a13-usb-phy" },
> > +	{ .compatible = "allwinner,sun6i-a31-usb-phy" },
> 
> Do you have Documentation for this comptible binding? Would be good to mention
> that in the commit log.

Ah right. I forgot.

I'm sending you a followup patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/ddd86fd1/attachment.sig>
