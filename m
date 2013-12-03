From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 09:48:36 +0000
Subject: [PATCH v4 17/17] usb: phy-mxs: do not set PWD.RXPWD1PT1 for low
 speed connection
In-Reply-To: <529DA44C.9090702@pengutronix.de>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
 <1386056231-17258-18-git-send-email-peter.chen@freescale.com>
 <529D9BF7.1080707@pengutronix.de>
 <F281D0F91ED19E4D8E63A7504E8A649804141031@039-SN2MPN1-021.039d.mgd.msft.net>
 <529DA44C.9090702@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A6498041410CD@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> On 12/03/2013 10:19 AM, Peter Chen wrote:
> >> On 12/03/2013 08:37 AM, Peter Chen wrote:
> >>> At very rare cases, the SoF will not send out after resume with
> >>> low speed connection. The workaround is do not power down
> >>> PWD.RXPWD1PT1 bit during the suspend.
> >>
> >> Is this also a fix for newly added code? If so please also squash.
> 
> > No, it is a workaround for new problem.
> 
> If this would be a fix, it's better to put this as first patch into a
> series, so that it can be applied to the stable trees easier.
> 

It is introduced by [3/17], without [3/17] it needs another fix which
we have not intended to use. I will squash them, thanks.

Peter

 
