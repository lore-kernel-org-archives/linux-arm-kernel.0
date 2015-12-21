From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 21:54:13 +0800
Subject: [PATCH v2] ARM: dts: imx7d: cl-som-imx7: add basic module support
In-Reply-To: <5677B341.6040203@compulab.co.il>
References: <20151208151401.GA20042@rob-hp-laptop>
 <1449756097-2921-1-git-send-email-grinberg@compulab.co.il>
 <20151214024315.GC25756@tiger> <56716EA4.2080107@compulab.co.il>
 <20151221063608.GB4703@tiger> <5677B341.6040203@compulab.co.il>
Message-ID: <20151221135413.GE18410@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2015 at 10:07:29AM +0200, Igor Grinberg wrote:
> >> Do you think we should document it in:
> >> Documentation/devicetree/bindings/arm/compulab-boards.txt
> >> (this file should already exist in arm-soc/next/dt)?
> > 
> > Yeah, if the file already exist, it's the best option.  But, as it
> > doesn't exist on my tree, I can not apply this change.
> 
> It is already in linux-next.
> Who do you think should apply the v2 patch then?
> May be the arm-soc guys? (Cc'ed Olof and Arnd)

I think the best approach here is you leave the change out from the
patch, and send that change to arm-soc folks.

Shawn
