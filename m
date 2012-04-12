From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Apr 2012 11:34:24 +0000
Subject: [PATCH v6 17/17] pwm: Take over maintainership of the PWM
 subsystem
In-Reply-To: <20120412072206.GB18252@avionic-0098.mockup.avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
 <201204101951.44198.arnd@arndb.de>
 <20120412072206.GB18252@avionic-0098.mockup.avionic-design.de>
Message-ID: <201204121134.24892.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 April 2012, Thierry Reding wrote:
>   * Arnd Bergmann wrote:
> > On Tuesday 10 April 2012, Thierry Reding wrote:
> > > I'm taking over the maintainership of the PWM subsystem. This commit
> > > also adds the URLs to the gitorious project and repository as well as
> > > any missing files related to the PWM subsystem.
> > > 
> > > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > > ---
> > > Note: I guess this patch in particular could use some Acked-by, maybe from
> > > Arnd and Sascha so that people will know this happens with their blessing.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> As far as I can tell the series is in pretty good shape. I've integrated
> Shawn's latest comments and I think we could get this into 3.5. Does it make
> sense to take the PWM tree through Linux next before having it pulled into
> mainline during the next merge window?

Yes, that's the way to go. Just ask Stephen Rothwell to include it right
away if you are sufficiently happy with the contents and believe that they
don't break stuff.

	Arnd
