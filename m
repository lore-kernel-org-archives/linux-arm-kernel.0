From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 22:07:18 +0800
Subject: [PATCH] gpio/generic: initialize the shadow of direction register
In-Reply-To: <20403.44198.671025.83880@ipc1.ka-ro>
References: <1337054198-24674-1-git-send-email-shawn.guo@linaro.org>
 <20402.798.622618.263780@ipc1.ka-ro>
 <20120516053301.GB21517@S2100-06.ap.freescale.net>
 <20403.20214.297216.188300@ipc1.ka-ro>
 <20120516072859.GE21517@S2100-06.ap.freescale.net>
 <20403.22671.800713.334846@ipc1.ka-ro>
 <CAAQ0ZWRpm8mrBnseepV17QMGZcz3W=vw4yYJR5UvSGg2i5dvgg@mail.gmail.com>
 <20403.41495.610333.670008@ipc1.ka-ro>
 <20120516133850.GA3764@S2100-06.ap.freescale.net>
 <20403.44198.671025.83880@ipc1.ka-ro>
Message-ID: <20120516140717.GB3764@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:33:26PM +0200, Lothar Wa?mann wrote:
> > I'm not fixing a gpio-mxs problem but a gpio-generic one.  Can you help
> >
> Yes, I know. And that's exaclty why you should make sure that you
> don't break other platforms by fixing yours!
> 
> > me understand what the new problems could possibly be introduced for
> > other gpio-generic users by the changes? 
> > 
> Another platform using might be working just _because_ of the "broken"
> behaviour. By fixing that brokenness for your driver you may break
> that other platform.
> 
Can you point me any such platform?

-- 
Regards,
Shawn
