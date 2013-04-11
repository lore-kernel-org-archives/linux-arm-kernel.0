From: olof@lixom.net (Olof Johansson)
Date: Thu, 11 Apr 2013 10:53:19 -0700
Subject: [GIT PULL 8/8] ARM: tegra: defconfig changes
In-Reply-To: <201304091716.36058.arnd@arndb.de>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-8-git-send-email-swarren@wwwdotorg.org>
 <201304091716.36058.arnd@arndb.de>
Message-ID: <20130411175319.GD373@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 05:16:35PM +0200, Arnd Bergmann wrote:
> On Friday 05 April 2013, Stephen Warren wrote:
> > Various new features are enabled:
> > 
> > * Tegra114 support.
> > * Various PMICs and related options for Tegra114 platforms.
> > * KEYBOARD_GPIO, mainly as a suspend wakeup source.
> > * tegra_defconfig is rebuilt based on v3.9-rc1, which causes various
> >   layout changes.
> > 
> > This branch is based on v3.9-rc1.
> 
> Pulled into next/soc.
> 
> I'm currently thinking about creating a next/defconfig branch after all,
> since we have a couple of pull requests in next/soc that only do
> defconfig changes. Olof, any opinion?

Sorry, didn't see this until now. Either way is fine with me. Main reason
for not keeping it in a branch on its own is that defconfig churn is
usually frowned upon and it makes some sense to show that it's caused
by other development (soc/board/etc).  But if we have enough volume to
keep separate then that's fine too.

Also, if we keep it separate we can always merge it together with another
branch before sending it up if it's very small for a particular merge window.


-Olof
