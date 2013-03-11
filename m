From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Mar 2013 22:34:55 +0000
Subject: [PATCH 9/9] ARM: spear3xx: Use correct pl080 header file
In-Reply-To: <CAKohponFisFjM9CbpHoR7h-pn1SAOWeck63v3FKZe4UV0cR2DQ@mail.gmail.com>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-10-git-send-email-arnd@arndb.de>
 <CAKohponFisFjM9CbpHoR7h-pn1SAOWeck63v3FKZe4UV0cR2DQ@mail.gmail.com>
Message-ID: <201303112234.55748.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 March 2013, Viresh Kumar wrote:
> On 6 March 2013 06:16, Arnd Bergmann <arnd@arndb.de> wrote:
> > The definitions have move around recently, causing build errors
> > in spear3xx for all configurations:
> >
> > spear3xx.c:47:5: error: 'PL080_BSIZE_16' undeclared here (not in a function)
> > spear3xx.c:47:23: error: 'PL080_CONTROL_SB_SIZE_SHIFT' undeclared here (not in a function)
> > spear3xx.c:48:22: error: 'PL080_CONTROL_DB_SIZE_SHIFT' undeclared here (not in a function)
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Alessandro Rubini <rubini@gnudd.com>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/mach-spear3xx/spear3xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> You are a bit late in posting this.
> We already got the same patch from Vipul yesterday :)

Are you going to send a pull request for that one then? Another -rc has
just passed with the platform being broken.

	Arnd
