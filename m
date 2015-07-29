From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 29 Jul 2015 12:41:29 +0800
Subject: [PATCH 02/10] usb: chipidea: define stream mode disable for both
 roles
In-Reply-To: <20150729051016.GB5502@kroah.com>
References: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
 <1438137734-27311-3-git-send-email-peter.chen@freescale.com>
 <20150729051016.GB5502@kroah.com>
Message-ID: <20150729044128.GB27605@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 10:10:16PM -0700, Greg KH wrote:
> On Wed, Jul 29, 2015 at 10:42:06AM +0800, Peter Chen wrote:
> > @@ -20,7 +20,6 @@ struct ci_hdrc_platform_data {
> >  	unsigned long	 flags;
> >  #define CI_HDRC_REGS_SHARED		BIT(0)
> >  #define CI_HDRC_SUPPORTS_RUNTIME_PM	BIT(2)
> > -#define CI_HDRC_DISABLE_STREAMING	BIT(3)
> 
> Why not just rename this one, now you have a "hole" in your bit field
> that people aren't going to know if they can use or not.
> 

I will change it, thanks.

-- 

Best Regards,
Peter Chen
