From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 22 Feb 2012 18:34:37 +0100
Subject: [PATCH v2 06/19] ARM: at91/pm_slowclock: rename register to
 named define
In-Reply-To: <20120222095040.GU22562@n2100.arm.linux.org.uk>
References: <0d78171672a30e8ec8084f54a557e9948260356d.1329903206.git.nicolas.ferre@atmel.com>
 <cce50d2859ae080d6bfd9260fcd6932d634f7b9a.1329903206.git.nicolas.ferre@atmel.com>
 <20120222095040.GU22562@n2100.arm.linux.org.uk>
Message-ID: <20120222173437.GG9407@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:50 Wed 22 Feb     , Russell King - ARM Linux wrote:
> On Wed, Feb 22, 2012 at 10:39:32AM +0100, Nicolas Ferre wrote:
> >  #define PLLALOCK_TIMEOUT	1000
> >  #define PLLBLOCK_TIMEOUT	1000
> >  
> > +#define pmc	r1
> 
> pmc	.req	r1
> sdramc	.req	r2
> 
> etc.
done

update
[PATCH v3 07/20] ARM: at91/pm_slowclock: function slow_clock() accepts parameters
[PATCH v3 06/20] ARM: at91/pm_slowclock: rename register to named define
[PATCH v3 10/20] ARM: at91/pm_slowclock: add runtime detection of memory contoller

we will see if we need to resend the full series

Best Regards,
J.
