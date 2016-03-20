From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 20 Mar 2016 09:38:36 +0100
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160209173807.GL19432@atomide.com>
References: <20160126172527.GY3500@atomide.com> <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd> <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com> <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com> <20160207212316.GA6147@amd>
 <20160209172403.GK19432@atomide.com>
 <20160209173807.GL19432@atomide.com>
Message-ID: <20160320083836.GB13408@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Oh and I also have the MMC PM runtime regression fix here that I
> > have not yet posted. Will post today. But I guess you're on
> > v4.4 right now still.
> 
> And looks like the USB RNDIS gadget has some extra issues
> breaking reboot. So I'd stick to ECM if possible and leave out
> RNDIS completely.

Thanks for the information. I should be using ECM

CONFIG_USB_F_ECM=y
# CONFIG_USB_ETH_RNDIS is not set

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
