From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 17:10:12 -0400
Subject: [PATCH] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <1403296977.16903.10.camel@x41>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com>
 <1396805315.7723.8.camel@x220> <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
 <1403296977.16903.10.camel@x41>
Message-ID: <20140620211012.GP21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 10:42:57PM +0200, Paul Bolle wrote:
> Jason Cooper schreef op vr 20-06-2014 om 16:21 [-0400]:
> > It looks like rmk just added a patch to fixing the selection of the
> > erratas.  Could you please take a look and either rebase or drop this
> > patch?
> 
> Sure, no problem. What tree should I check?

It's

  a641f3a6abce ARM: l2c: fix dependencies on PL310 errata symbols

in Russell's fixes branch:

  http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git fixes

thx,

Jason.
