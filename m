From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 May 2014 13:48:49 +0200
Subject: [PATCH 00/22] Random ARM randconfig fixes in drivers
In-Reply-To: <20140508164157.GA22224@roeck-us.net>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <20140508164157.GA22224@roeck-us.net>
Message-ID: <201405091348.49713.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 08 May 2014, Guenter Roeck wrote:
> On Thu, May 08, 2014 at 04:46:51PM +0200, Arnd Bergmann wrote:
> > These are a bunch of fixes I had to do to get all randconfig
> > configurations on ARM working. Most of these are really old
> > bugs, but there are also some new ones. I don't think any of
> > them require a backport to linux-stable.
> > 
> > I have checked that they are all still required on yesterday's
> > linux-next kernel. Please apply on the appropriate trees unless
> > there are objections.
> > 
> Is this series of patches also going to fix arm:allmodconfig ?

Possibly, I haven't checked in a while. I'm unfortunately sitting on
about 200 other patches in the same branch, which together fix all
build errors in any configuration I encountered.

I should really do some allmodconfig/allnoconfig/allyesconfig
builds without my series again, and prioritize sending out the
ones required for that.

	Arnd
