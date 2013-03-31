From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Mar 2013 22:23:40 +0800
Subject: [PATCH v6 0/8] Reset controller API to reset IP modules on i.MX5
 and i.MX6
In-Reply-To: <201303282207.54250.arnd@arndb.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
 <201303282207.54250.arnd@arndb.de>
Message-ID: <20130331142339.GD17773@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 10:07:54PM +0000, Arnd Bergmann wrote:
> On Thursday 28 March 2013, Philipp Zabel wrote:
> > [Added Arnd and Greg to the recipients] I think the first three patches
> > of this series are candidates to go through Arnd's tree. Arnd, would you
> > take those patches?
> >         [PATCH v6 1/8] dt: describe base reset signal binding
> >         [PATCH v6 2/8] reset: Add reset controller API
> >         [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
> 
> Wow, very nice work. I had completely missed the series so far, as I'm
> quite behind on reading mailing lists.
> 
> Yes, I can certainly take the three patches through arm-soc. Actually
> I just handed over to Olof for now, but I'm assume he will also take
> them when you send a pull request.
> 
> We also have at least one other platform (sirf/prima2) that will need
> the subsystem in the near future. I'm probably stating the obvious here,
> but  please make sure that the pull request you send for arm-soc uses
> the exact git sha1 IDs that will be used for the follow-on patches
> going through the platform trees.

Ok, let me maintain a stable branch on IMX tree and forward the patches
to arm-soc, since the other patches in the series that I need to handle
will depend on the branch anyway.

Shawn
