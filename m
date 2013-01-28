From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Jan 2013 16:37:18 +0800
Subject: [PATCH 4/4] cpufreq, highbank: add support for highbank cpufreq
In-Reply-To: <1523559.2KevGvelzH@vostro.rjw.lan>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1359143205-20279-5-git-send-email-mark.langsdorf@calxeda.com>
 <20130126143950.GA7079@S2101-09.ap.freescale.net>
 <1523559.2KevGvelzH@vostro.rjw.lan>
Message-ID: <20130128083716.GE31689@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael,

On Sat, Jan 26, 2013 at 11:24:12PM +0100, Rafael J. Wysocki wrote:
> > As we are moving to multiplatform build, this init function will run
> > on all other platforms built together with highbank.  We should
> > probably eliminate that effect.
> 
> That change can be made on top of the Mark's patches I think, right?
> 
Yes.

> If so, I'd prefer it that way.  The Mark's patches have been in a limbo for
> too long already and that issue doesn't seem to be serious enough to block
> them any longer.
> 
Ok, I will take care of the changes needed on highbank.  Do you have
a branch with Mark's series and the EXPORT_SYMBOL() one applied,
so that I can start my patch from there.

Shawn
