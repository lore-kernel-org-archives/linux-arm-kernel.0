From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 18 Apr 2012 20:49:53 +0200
Subject: [PATCH v2 0/9] PM: Create the AVS class of drivers
In-Reply-To: <878vhski53.fsf@ti.com>
References: <1332173578-27422-1-git-send-email-j-pihet@ti.com>
 <878vhski53.fsf@ti.com>
Message-ID: <201204182049.53212.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 18, 2012, Kevin Hilman wrote:
> Rafael,
> 
> jean.pihet at newoldbits.com writes:
> 
> > From: Jean Pihet <j-pihet@ti.com>
> >
> > AVS is a power management technique which controls the operating
> > voltage of a device in order to optimize (i.e. reduce) its power
> > consumption. The voltage is adapted depending on static factors
> > (chip manufacturing process) and dynamic factors (temperature
> > depending performance).
> > AVS is also called SmartReflex on OMAP devices.
> >
> > To that end, create the AVS framework in drivers/power/avs and
> > move the OMAP SmartReflex code to the new directory.
> 
> I've done a review of this series and had a few very minor comments.
> 
> Once those are addressed, are you OK with us moving this AVS driver
> under drivers/power?

Yes, I am.

Thanks,
Rafael
