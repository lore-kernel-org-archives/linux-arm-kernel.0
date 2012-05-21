From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 07:39:46 +0200
Subject: [PATCH] ARM: mxs: Let GPMI driver be built by default
In-Reply-To: <CAAQ0ZWQimyVfCfDyzMAnXJa2EGcZZ2hXnWK4117G4ubbFX9kUw@mail.gmail.com>
References: <1337570413-31407-1-git-send-email-festevam@gmail.com>
 <201205210648.10838.marex@denx.de>
 <CAAQ0ZWQimyVfCfDyzMAnXJa2EGcZZ2hXnWK4117G4ubbFX9kUw@mail.gmail.com>
Message-ID: <201205210739.46619.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On 21 May 2012 12:48, Marek Vasut <marex@denx.de> wrote:
> > Heh, if we get such trivial things in so late, the imx28 will be dead
> > platform by the time it's supported mainline :-)
> 
> It's late for v3.5 merge window.

Well back in -around .30- it was still ok to add minor stuffs even if it was 
around rc1, they didn't break anything afterall. And this doesn't break anything 
(well, the gpmi driver is broken, so fix it ... if you get more people to use 
it, you'll have the fixes pouring your direction ... isn't that your objective, 
to make linux kernel even better than it is?)

> Regards,
> Shawn

Best regards,
Marek Vasut
