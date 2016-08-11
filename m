From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Aug 2016 23:51:38 +0200
Subject: [PATCH 1/5] arm/defconfigs: Remove CONFIG_IPV6_PRIVACY
In-Reply-To: <20160811213521.GD10636@nazgul.tnic>
References: <1459338168-29334-1-git-send-email-bp@alien8.de>
 <4958578.R1lMSWqhcA@wuerfel> <20160811213521.GD10636@nazgul.tnic>
Message-ID: <1769762.X0BZWCkYAE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 11, 2016 11:35:21 PM CEST Borislav Petkov wrote:
> On Thu, Aug 11, 2016 at 10:26:26PM +0200, Arnd Bergmann wrote:
> > I'd prefer not to do it mechanically, please check the things that
> > changed to see if they made sense.
> 
> I'm hardly the guy to be in the position to verify ARM config stuff.
> Actually, my original intention was much simpler:
> 
> https://lkml.kernel.org/r/1459338168-29334-2-git-send-email-bp at alien8.de
> 
> but then Vladimir suggested I should do the savedefconfig thing.
> 

That patch looks good, sorry I missed it. I see that Vladimir already
did the lpc32xx portion of it, can you send the part for s3c24xx
to the exynos maintainers?

If you have larger chunks like CONFIG_INET_LRO removal, we can take
that directly through arm-soc as a single patch for all defconfigs.

	Arnd
