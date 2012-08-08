From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 08 Aug 2012 12:52:33 +0100
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1344426500.2435.39.camel@hornet>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <1344426500.2435.39.camel@hornet>
Message-ID: <1344426753.2435.40.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-08 at 12:48 +0100, Pawel Moll wrote:
> On Mon, 2012-08-06 at 17:32 +0100, Linus Walleij wrote:
> > This converts the ARM RealView machine over to using the common
> > clock. The approach is similar to the one used for the Integrator,
> > and we're reusing the ICST wrapper code.
> 
> I've just tried it with v3.6-rc1 and an EB Model and I get this:
> 
> ------------[ cut here ]------------
> WARNING: at /home/pawmol01/src/kernel.org/linux/kernel/timer.c:1076 del_timer_sync+0x34/0x5c()

Err. Ignore that. The same happens without your patch :-)

Will try with 3.5.

Pawe?
