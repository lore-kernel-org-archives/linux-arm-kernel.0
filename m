From: marex@denx.de (Marek Vasut)
Date: Thu, 25 Jul 2013 14:36:26 +0200
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <20130725055855.GA4924@nchen-desktop>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307250755.23403.marex@denx.de> <20130725055855.GA4924@nchen-desktop>
Message-ID: <201307251436.27161.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> On Thu, Jul 25, 2013 at 07:55:23AM +0200, Marek Vasut wrote:
> > Hi Peter,
> > 
> > > I have not tried the manual switching, but first, you need to close
> > > your vbus supply.
> > 
> > I think we can close this issue, I will now be also getting MX28EVK.
> > Thanks for all your help!
> 
> Great. What's the problem? Any changes for this patchset?

No changes needed, I had VDD5V constantly tied to 5V so I didn't get the VBUS 
interrupt.

Best regards,
Marek Vasut
