From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Jan 2017 00:03:52 +0100
Subject: [PATCH 2/2] isdn: i4l: move active-isdn drivers to staging
In-Reply-To: <1483484256.13649.13.camel@tiscali.nl>
References: <1456945629-1793533-1-git-send-email-arnd@arndb.de>
 <3780968.pTT7cvIH4p@wuerfel> <1483484256.13649.13.camel@tiscali.nl>
Message-ID: <10507790.a4n3csIkKa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 3, 2017 11:57:36 PM CET Paul Bolle wrote:
> On Tue, 2017-01-03 at 23:25 +0100, Arnd Bergmann wrote:
> > As far as I'm concerned, we are totally fine as long as there exists a
> > longterm supported kernel that has i4l in drivers/staging.
> 
> Or in drivers/isdn, right?

Right, I was assuming that we would first move it to staging and then
delete it, both at future points in time that we can debate. With the
existing longterm kernels that have i4l in drivers/isdn, the few remaining
users still have access to a supported kernel release until at least
2020.

	Arnd
