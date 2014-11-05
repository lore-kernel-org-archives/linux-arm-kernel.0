From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 5 Nov 2014 19:12:31 +0100
Subject: [PATCH 0/2] clk: at91: usb: rate calculation fixes
In-Reply-To: <545A5AB5.2040805@atmel.com>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
 <545A5AB5.2040805@atmel.com>
Message-ID: <20141105191231.7ed5d5a3@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Wed, 5 Nov 2014 18:13:25 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On 05/11/2014 10:33, Boris Brezillon :
> > Hello,
> > 
> > Here are a few more fixes for the at91 usb clk driver.
> > 
> > These bugs are related to rate calculation, and have been reported by
> > Andreas.
> > 
> > As this is not my first mistake in this rate calculation algorithm, I'd
> > really like to have reviews/feedback on this fixes to avoid potential
> > regressions.
> > 
> > Mike, when/if we agree on these fixes, can we make them go into one of
> > the 3.18-rc cycle ?
> 
> Can you give us a hint about the "stable tag" that would be good to add?

None for the moment: these 2 patches apply on top of other patches that
were merge in 3.18.
What we should do though is backport the set of usb fixes merged in 3.18
to 3.16/3.17 once 3.18 is out...

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
