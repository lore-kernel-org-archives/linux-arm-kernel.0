From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 28 Jan 2015 15:19:24 +0000
Subject: [PATCH v5] can: Convert to runtime_pm
In-Reply-To: <54C8F62D.6090909@pengutronix.de>
References: <baf987c11c0242c2bf87b81f9396b09d@BN1BFFO11FD018.protection.gbl>
 <54C8F62D.6090909@pengutronix.de>
Message-ID: <1ae6a3ca4fad4104a673b9a6c7e44998@BY2FFO11FD036.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Wednesday, January 28, 2015 8:16 PM
> To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek;
> Soren Brinkmann; grant.likely at linaro.org; robh+dt at kernel.org
> Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Appana Durga Kedareswara Rao
> Subject: Re: [PATCH v5] can: Convert to runtime_pm
>
> On 01/12/2015 04:04 PM, Kedareswara rao Appana wrote:
> > Instead of enabling/disabling clocks at several locations in the
> > driver, Use the runtime_pm framework. This consolidates the actions
> > for runtime PM In the appropriate callbacks and makes the driver more
> readable and mantainable.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v5:
> >  - Updated with the review comments.
> >    Updated the remove fuction to use runtime_pm.
> > Chnages for v4:
> >  - Updated with the review comments.
> > Changes for v3:
> >   - Converted the driver to use runtime_pm.
> > Changes for v2:
> >   - Removed the struct platform_device* from suspend/resume
> >     as suggest by Lothar.
>
> Any plans to submit a v6?

I was on vacation till yesterday just came to office today only. Will look into it and will send v6 at the earliest.

Regards,
Kedar.

>
> Marc
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
