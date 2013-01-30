From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Jan 2013 14:57:25 +0800
Subject: [RESEND PATCH v5 3/7] usb: chipidea: add otg id switch and
 vbus connect/disconnect detect
In-Reply-To: <5108B872.6050706@ti.com>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-4-git-send-email-peter.chen@freescale.com>
 <5108B872.6050706@ti.com>
Message-ID: <20130130065724.GC699@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:36:42AM +0530, kishon wrote:
> Hi,
> 
> >  	bool				global_phy;
> >  	struct usb_phy			*transceiver;
> >  	struct usb_hcd			*hcd;
> >-	struct usb_otg      otg;
> >+	struct usb_otg      		otg;
> You have added *otg* in previous patch and added a tab for *otg* in
> this patch.
thanks, I will change at previous patch
> 
> >+
> >+#define CI_VBUS_STABLE_TIMEOUT 500
> 
> Just curious.. how was this timeout value obtained?

Just a timeout value, if the vbus goes to required value, it will quit.
Besides, 5s for vbus stable should be enough for an well behaviour hardware.

> 
> Thanks
> Kishon
> 

-- 

Best Regards,
Peter Chen
