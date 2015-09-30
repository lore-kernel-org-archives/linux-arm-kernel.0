From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 30 Sep 2015 21:37:12 +0800
Subject: [RESEND PATCH v2 2/2] ARM: imx6: change default burst size for USB
In-Reply-To: <1443603159.3185.5.camel@pengutronix.de>
References: <1443579437-845-1-git-send-email-peter.chen@freescale.com>
 <1443579437-845-2-git-send-email-peter.chen@freescale.com>
 <1443603159.3185.5.camel@pengutronix.de>
Message-ID: <20150930133712.GG16362@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 10:52:39AM +0200, Lucas Stach wrote:
> Am Mittwoch, den 30.09.2015, 10:17 +0800 schrieb Peter Chen:
> > It can improve the USB performance when choosing larger
> > burst size at some systems (bus size is larger), there is
> > no side effect if this burst size is larger than bus size.
> > 
> Just for the record, as it seems too late to stop the train now:
> 
> I am _NOT_ happy that the extended binding has been accepted into the
> USB tree despite outstanding review comments from me not being addressed
> or even answered.

Okay.  I'm not aware of this.  I'm dropping the patches until everyone
agrees with it.

Shawn
