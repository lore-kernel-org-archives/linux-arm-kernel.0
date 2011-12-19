From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 13:07:29 -0500 (EST)
Subject: [PATCH 12/20] ARM: mach-msm: hook special idle handlers to
 arm_pm_idle
In-Reply-To: <20111219175636.GJ6464@atomide.com>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
 <1324288069-21940-13-git-send-email-nico@fluxnic.net>
 <20111219175636.GJ6464@atomide.com>
Message-ID: <alpine.LFD.2.02.1112191305370.2907@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Dec 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nico@fluxnic.net> [111219 01:42]:
> > --- /dev/null
> > +++ b/arch/arm/mach-msm/idle.c
> > @@ -0,0 +1,49 @@
> > +/* arch/arm/mach-msm/idle.c
> > + *
> > + * Idle processing for MSM7K - work around bugs with SWFI.
> > + *
> > + * Copyright (c) 2007 QUALCOMM Incorporated.
> > + * Copyright (C) 2007 Google, Inc. 
> 
> Trailing whitespace here too "<stdin>:62: trailing whitespace.".

I just did "git rebase --whitespace=fix" on my branch.  They should all 
be gone now.


Nicolas
