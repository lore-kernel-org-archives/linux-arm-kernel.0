From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 8 Apr 2013 21:36:44 +0200
Subject: GENERIC_GPIO considered deprecated
In-Reply-To: <5162EC32.2030602@wwwdotorg.org>
References: <CAAVeFu+QUw1WmzwaJDfjyw75PrStd3p3PHs1MU5BC7_WXMB7kw@mail.gmail.com>
 <2c9501ce342b$1535d290$3fa177b0$%kim@samsung.com>
 <5162EC32.2030602@wwwdotorg.org>
Message-ID: <201304082136.44905.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Stephen Warren wrote:
> >>
> >> Should do the trick, if we can make sure that your tree is merged
> >> prior to my patches.
> > 
> > I'm not sure but I think, arm-soc tree should be merged into mainline before others...
> > 
> >> Can you put it into your tree for 3.10?
> >>
> > I did, so it should be fine.
> > 
> 
> You may want to discuss how to handle this dependency with the arm-soc
> maintainers (CC'd).

I'm fine with putting the same branch into arm-soc as well as the gpio tree
and anything else that might need it, that tends to be the least invasive
way.

	Arnd
