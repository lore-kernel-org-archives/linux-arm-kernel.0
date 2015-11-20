From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 21:03:03 +0100
Subject: [PATCH 01/11] dt-bindings: clock: add description of LPC32xx
 clock controller
In-Reply-To: <564F5FDC.2070001@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
 <3740707.LksPCoyRXC@wuerfel> <564F5FDC.2070001@mleia.com>
Message-ID: <6347608.0ASvek9R2Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 November 2015 20:01:00 Vladimir Zapolskiy wrote:
> > 
> > Please use a specific model number without 'xx' wildcards. If you have
> > multiple chips that are mutually compatible, pick one as the base number
> > and then list the others as more specific instances, like
> > 
> >       compatible = "nxp,lpc3250-clk", "nxp,lpc3220-clk";
> 
> Do you ask me to change a title? You may see that compatible property
> does not contain any wildcards?
> 

Nevermind, I saw so many 'xx's that I didn't notice you got the
important one right.

	Arnd
