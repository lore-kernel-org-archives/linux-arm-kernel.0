From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Nov 2011 06:59:03 +0800
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <4ECE66B0.5010802@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <20111124125952.GD18060@S2100-06.ap.freescale.net>
 <4ECE66B0.5010802@prolan.hu>
Message-ID: <20111124225902.GF18060@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 04:45:52PM +0100, Peter Rusko wrote:
> >I think this patch should probably be split into 4.
> >
> >  * lradc drivers/staging/iio/adc/ (rather than drivers/misc/) part
> >  * lradc arch/arm/mach-mxs part
> >  * touchscreen drivers/input/touchscreen part
> >  * touchscreen arch/arm/mach-mxs part
> >
> >And you need to look into MAINTAINERS for the mailing list and people
> >that the 'drivers' part should be sent to.
> >
> 
> You're right, I'm working on it.
> 
> Shall I split the arch/arm/mach-mxs parts? In this patch I use
> HAVE_MXS_LRADC to compile both of them. I think they come together,
> the ADC supports the touchscreen, so there is no need to split them.
> 
But touchscreen is not the only one that ADC supports, right?

-- 
Regards,
Shawn
