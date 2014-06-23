From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 23 Jun 2014 09:58:43 +0200
Subject: [PATCH] ARM: mvebu: rename ARM_ERRATA_753970
In-Reply-To: <20140620211012.GP21711@titan.lakedaemon.net>
References: <201404052101.19381.arnd@arndb.de>
 <201404052104.11363.arnd@arndb.de> <1396777049.30640.9.camel@x220>
 <53418889.2050002@free-electrons.com> <1396805315.7723.8.camel@x220>
 <1401094871.25902.20.camel@x220>
 <20140620202100.GG21711@titan.lakedaemon.net>
 <1403296977.16903.10.camel@x41>
 <20140620211012.GP21711@titan.lakedaemon.net>
Message-ID: <1403510323.12982.5.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-06-20 at 17:10 -0400, Jason Cooper wrote:
> On Fri, Jun 20, 2014 at 10:42:57PM +0200, Paul Bolle wrote:
> > Jason Cooper schreef op vr 20-06-2014 om 16:21 [-0400]:
> > > It looks like rmk just added a patch to fixing the selection of the
> > > erratas.  Could you please take a look and either rebase or drop this
> > > patch?
> > 
> > Sure, no problem. What tree should I check?
> 
> It's
> 
>   a641f3a6abce ARM: l2c: fix dependencies on PL310 errata symbols
> 
> in Russell's fixes branch:
> 
>   http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git fixes

Thanks. That commit landed in linux-next in next-20140620. It addresses
all comments I made, below the --- marker, in
https://lkml.org/lkml/2014/5/26/103 . It makes it a bit easier to reason
about the PL310_ERRATA_* symbols. I hope to submit a v2 soon.


Paul Bolle
