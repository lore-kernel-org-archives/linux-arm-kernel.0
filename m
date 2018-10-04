From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 4 Oct 2018 13:13:42 +0200
Subject: [PATCHv2 2/3] PCI: mvebu: Convert to PCI emulated bridge config
 space
In-Reply-To: <20181004104805.GB5233@e107981-ln.cambridge.arm.com>
References: <20180912154831.2220-1-thomas.petazzoni@bootlin.com>
 <20180912154831.2220-3-thomas.petazzoni@bootlin.com>
 <20180918161745.GB31440@e107981-ln.cambridge.arm.com>
 <20181004104805.GB5233@e107981-ln.cambridge.arm.com>
Message-ID: <20181004131342.130d356a@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 4 Oct 2018 11:48:05 +0100, Lorenzo Pieralisi wrote:

> > I would drop "recently introduced", unless we can define a precise
> > commit when code was added so that it can actually be checked (I know
> > you can't since the relevant patch is part of this series and not in
> > the mainline yet).
> > 
> > Bjorn posted some guidelines that are helpful:
> > 
> > https://marc.info/?l=linux-pci&m=150905742808166&w=2
> > 
> > I can make these changes myself, no problem but please address Russell's
> > comment so that we can proceed.  
> 
> Hi Thomas,
> 
> I understand you have more important things to think about these days :)
> (congratulations), let me know if I can fix this patch up myself, I
> would like to merge this series for v4.20.

Fixing up the commit log, of course, you can fix up yourself. However,
Russell made a comment about a remaining FIXME, and I haven't had the
chance to get back deep into the code to remember why I added this
FIXME, and whether it is still needed or not.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
