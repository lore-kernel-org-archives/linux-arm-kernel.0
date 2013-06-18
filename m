From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 18 Jun 2013 19:55:56 +0300
Subject: [PATCH v2 3/5] USB: OMAP1: OTG controller driver
In-Reply-To: <20130618082143.GE5461@arwen.pp.htv.fi>
References: <1371389712-29516-1-git-send-email-aaro.koskinen@iki.fi>
 <1371389712-29516-4-git-send-email-aaro.koskinen@iki.fi>
 <20130618082143.GE5461@arwen.pp.htv.fi>
Message-ID: <20130618165556.GD3073@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 18, 2013 at 11:21:43AM +0300, Felipe Balbi wrote:
> On Sun, Jun 16, 2013 at 04:35:10PM +0300, Aaro Koskinen wrote:
> > +#include <mach/usb.h>
> 
> no mach/* includes under drivers/usb, sorry. It's a pain to fix those up
> later.

Sorry, that was left there by a mistake. I will fix.

A.
