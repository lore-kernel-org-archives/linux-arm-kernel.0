From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 May 2012 13:48:44 +0800
Subject: [PATCH] ARM: mxs: Let GPMI driver be built by default
In-Reply-To: <201205210739.46619.marex@denx.de>
References: <1337570413-31407-1-git-send-email-festevam@gmail.com>
 <201205210648.10838.marex@denx.de>
 <CAAQ0ZWQimyVfCfDyzMAnXJa2EGcZZ2hXnWK4117G4ubbFX9kUw@mail.gmail.com>
 <201205210739.46619.marex@denx.de>
Message-ID: <20120521054842.GD8140@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 07:39:46AM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On 21 May 2012 12:48, Marek Vasut <marex@denx.de> wrote:
> > > Heh, if we get such trivial things in so late, the imx28 will be dead
> > > platform by the time it's supported mainline :-)
> > 
> > It's late for v3.5 merge window.
> 
> Well back in -around .30- it was still ok to add minor stuffs even if it was 
> around rc1, they didn't break anything afterall. And this doesn't break anything 
> (well, the gpmi driver is broken, so fix it ... if you get more people to use 
> it, you'll have the fixes pouring your direction ... isn't that your objective, 
> to make linux kernel even better than it is?)
> 
The -rc should mostly be for bugfix.  I also hope we can enable the
driver in defconfig as soon as possible, but I won't do it until the
driver is actually working with all known bugs fixed. 

-- 
Regards,
Shawn
