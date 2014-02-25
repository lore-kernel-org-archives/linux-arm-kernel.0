From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 25 Feb 2014 02:03:26 +0000
Subject: [PATCH v11 09/15] usb: phy: Add set_wakeup API
In-Reply-To: <530B9243.4020909@cogentembedded.com>
References: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
 <1393208467-6355-10-git-send-email-peter.chen@freescale.com>
 <530B9243.4020909@cogentembedded.com>
Message-ID: <a887d9e37b63456d8e224196357f0460@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> On 02/24/2014 05:21 AM, Peter Chen wrote:
> 
> > This API is used to set wakeup enable at PHY registers, in that case,
> > the PHY can be waken up from suspend due to external events, like vbus
> > change, dp/dm change and id change.
> 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >   include/linux/usb/phy.h |   16 ++++++++++++++++
> >   1 files changed, 16 insertions(+), 0 deletions(-)
> 
> > diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h index
> > 6c0b1c5..c2c6f49 100644
> > --- a/include/linux/usb/phy.h
> > +++ b/include/linux/usb/phy.h
> > @@ -111,6 +111,13 @@ struct usb_phy {
> >   	int	(*set_suspend)(struct usb_phy *x,
> >   				int suspend);
> >
> > +	/*
> > +	 * Set wakeup enable for PHY, in that case, the PHY can be
> > +	 * waken up from suspend status due to external events,
> 
>     s/waken/woken/
> 
> WBR, Sergei
> 
> 

Thanks, will change.

Peter
