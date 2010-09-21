From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 21 Sep 2010 19:11:01 +0530
Subject: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
In-Reply-To: <1285076060.14206.3.camel@chotu>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
	<1285076060.14206.3.camel@chotu>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A3478@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande at nokia.com] 
> Sent: Tuesday, September 21, 2010 7:04 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; linux-input at vger.kernel.org; 
> Dmitry Torokhov; linux-arm-kernel at lists.infradead.org; Tony Lindgren
> Subject: Re: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> Hi Manjunath,
> 
> On Tue, 2010-09-21 at 13:49 +0200, ext G, Manjunath Kondaiah wrote:
> > The failure exit paths seems to be wrong in probe function.
> > This patch corrects exit failure paths for error handling cases.
> 
> https://patchwork.kernel.org/patch/160551/
> Any comments on this?

Looks fine. Sorry, I didn't look at the change. This version seems to 
be better. 

-Manjunath
