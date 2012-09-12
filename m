From: krohei@gmail.com (Heikki Krogerus)
Date: Wed, 12 Sep 2012 13:39:01 +0300
Subject: [PATCH v2 06/11] USB: mxs-phy: add basic otg support
In-Reply-To: <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120912103901.GA6614@as23.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 28, 2012 at 03:03:12PM +0800, Richard Zhao wrote:
> +static int mxs_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{

Shouldn't you at least save the host pointer?

otg->host = host;

> +	return 0;
> +}
> +
> +static int mxs_phy_set_peripheral(struct usb_otg *otg,
> +					struct usb_gadget *gadget)
> +{

And the same with the gadget?

> +	return 0;
> +}

-- 
heikki
