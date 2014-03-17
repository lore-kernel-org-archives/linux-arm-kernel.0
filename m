From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Mar 2014 11:29:58 -0400
Subject: [PATCH 4/4] ARM: add Marvell Dove and some drivers to multi_v7
 defconfig
In-Reply-To: <20140304040729.GJ1872@titan.lakedaemon.net>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393536486-3827-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140304040729.GJ1872@titan.lakedaemon.net>
Message-ID: <20140317152958.GJ15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Here's the multi_v7_defconfig change I was referring to:

https://lkml.kernel.org/r/1393536486-3827-5-git-send-email-sebastian.hesselbarth at gmail.com

On Mon, Mar 03, 2014 at 11:07:29PM -0500, Jason Cooper wrote:
> Arnd, Olof, Kevin,
> 
> On Thu, Feb 27, 2014 at 10:28:05PM +0100, Sebastian Hesselbarth wrote:
> > With Marvell Dove now being part of the multi_v7 family, add some Dove
> > specific drivers to multi_v7 defconfig.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Gregory Clement <gregory.clement@free-electrons.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-kernel at vger.kernel.org
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> I'm taking the other part of this series in, so:
> 
> Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
