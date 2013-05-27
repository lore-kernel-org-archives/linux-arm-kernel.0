From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 27 May 2013 12:31:40 +0200
Subject: [RFC PATCHv4 0/6] arm: Initial TI-Nspire support
In-Reply-To: <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <201305262323.29519.arnd@arndb.de>
 <30BA4666-664F-4DA4-A1D5-C2B8AA63C6AB@gmail.com>
Message-ID: <201305271231.40693.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 May 2013, Daniel Tang wrote:
> > The one remaining bit that sticks out is the clcd platform data. As I
> > said before, I won't require you to convert that to DT in order to
> > get your code merged, but I'd also really like to see that happen,
> > as we will also need that to get rid of auxdata on the ARM reference
> > platforms (integrator, versatile, realview, vexpress).
> 
> How would you like me to convert the platform data to DT? AFAIK, the clcd
> driver isn't aware of DT so the only way is to use the AUXDATA right now.

Linus Walleij mentioned on IRC that Pawel Moll already posted a series
that adds DT support for clcd:

http://lists.freedesktop.org/archives/dri-devel/2013-April/037519.html

The series does a few more things, but you can probbly split out the
parts you need and base on that.

	Arnd
