From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:48:41 +0200
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.11
In-Reply-To: <20130620064541.GE5523@atomide.com>
References: <51C23902.1080301@ti.com> <20130620064541.GE5523@atomide.com>
Message-ID: <201306202148.41464.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 June 2013, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [130619 16:10]:
> > Hi Tony,
> > 
> > Please pull the following commits for OMAP Device Tree for v3.11.
> > 
> > It does contains as well 2 clock data patches, I hope it will not generate any conflict with Paul's tree. 
> > 
> > Special thanks to Florian for his nice cleanup using the C preprocessor.
> 
> It's best that Arnd and Olof take this pull request directly as we're
> getting so close to the merge window. These patches should be pretty
> much independent of the other branches I've sent, and are needed to
> keep omap4 booting now that we've flipped the switch for omap4 to be  
> DT only.
> 

Would someone provide a merge description for this? I just noticed
that it's not a signed tag, and there are lots of patches in it,
so I'd rather not have to come up with something myself.


	Arnd
