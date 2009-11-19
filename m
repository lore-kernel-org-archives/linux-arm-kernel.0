From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 Nov 2009 09:04:27 -0800
Subject: [PATCH 1/4] input: atmel_tsadcc: touchscreen rework setting
	capabilities
In-Reply-To: <4B05224B.8050403@atmel.com>
References: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com>
	<20091118173033.GA4385@core.coreip.homeip.net>
	<4B05224B.8050403@atmel.com>
Message-ID: <20091119170427.GC15647@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 11:47:39AM +0100, Nicolas Ferre wrote:
> Dmitry Torokhov :
> > Hi Nicolas,
> > 
> > On Wed, Nov 18, 2009 at 03:12:12PM +0100, Nicolas Ferre wrote:
> >> Tiny patch for setting capabilities using input API function.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > All looks good. Since the series span platform and input subtrees how do
> > you want to merge it?
> 
> I propose that you merge the whole series using the input path.
> 
> I had the acknowledgment from Andrew Victor offline. So, could you
> please add on patches #3 & #4:
> 
> Acked-by: Andrew Victor <linux@maxim.org.za>
> 
> Thanks a lot.
> 

OK, I will.

-- 
Dmitry
