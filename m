From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jan 2013 11:59:11 +0000
Subject: [PATCH 2/3] ARM: ux500: Turn on the 'heartbeat' LED trigger
In-Reply-To: <201301091156.55644.arnd@arndb.de>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
 <20130109110840.GD31678@gmail.com>
 <20130109111209.GH3931@n2100.arm.linux.org.uk>
 <201301091156.55644.arnd@arndb.de>
Message-ID: <20130109115911.GI3931@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 11:56:55AM +0000, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Russell King - ARM Linux wrote:
> > > If so, that's wrong, as it covers many more boards than just Snowball
> > > and this is only applicable on the Snowball board. So how else can
> > > I enable this feature?
> > 
> > And why is it wrong to enable an optional feature in a defconfig which some
> > boards using that defconfig may want?
> > 
> > It's less wrong than forcing user selectable options to be mandatorily
> > selected.
> 
> Right. The change I suggested fixes the build errors but doesn't actually
> make the intended behavior correct. Just using a configuration file is the
> right solution here.

Hang on a moment: if the lack of the LEDs support leads to build errors,
doesn't that mean there's missing conditional compilation?
