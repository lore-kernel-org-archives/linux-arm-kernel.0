From: nsekhar@ti.com (Nori, Sekhar)
Date: Wed, 2 Feb 2011 21:07:08 +0530
Subject: [PATCH v1 1/4] davinci: da8xx/omap-l1: add support for SPI
In-Reply-To: <4D496EC7.1010808@criticallink.com>
References: <1296596979-18524-1-git-send-email-michael.williamson@criticallink.com>
	<1296596979-18524-2-git-send-email-michael.williamson@criticallink.com>
	<4D494C6A.30507@mvista.com> <4D49543A.1070302@criticallink.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302487782C9@dbde02.ent.ti.com>
	<4D496EC7.1010808@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024877837A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wed, Feb 02, 2011 at 20:18:39, Michael Williamson wrote:
 
> > Since all the platform device definitions for DA8XX devices happens
> > in devices-da8xx.c, it makes sense to get rid of the DA830_DMACH_*
> > enum altogether and instead just define the channel numbers used in
> > devices-da8xx.c above the actual usage.
> > 
> > Mike, is that something you are willing take-up?
> > 
> 
> 
> I can take this up as a separate patch series. I'd like to keep the 
> spi platform support series isolated to that subject matter, if that's
> OK.

Yes, the clean-up can be a separate series - but it will have to
precede the SPI series.

Thanks,
Sekhar
