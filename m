From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Sep 2014 22:15:29 +0200
Subject: [PATCH] ARM: sunxi: Remove sun4i reboot code from mach directory
In-Reply-To: <7hoauuyuyl.fsf@paris.lan>
References: <1409332787-23923-1-git-send-email-maxime.ripard@free-electrons.com>
 <7hoauuyuyl.fsf@paris.lan>
Message-ID: <201409052215.30171.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 September 2014, Kevin Hilman wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> writes:
> 
> > Now that the restart code has been merged in the watchdog driver, we don't need
> > the restart code in the mach-sunxi directory anymore.
> >
> > Remove it entirely.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >
> > Hi Arnd, Kevin, Olof,
> >
> > I don't know if this can be considered 3.17 material, but if so, it would be
> > great if you could merge it directly.
> 
> I don't think it's v3.17 material at this point in the cycle because
> it's not a regression fix.
> 
> Please add it to your queue for v3.18.

I agree. I had actually put it into my apply-for-3.18 queue already, but
it's better if this comes through the normal cleanups from Maxime, unless
he has nothing else yet and prefers me to apply it to the next/cleanup
branch now.

	Arnd
