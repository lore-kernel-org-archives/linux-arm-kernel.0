From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Jul 2014 15:27:33 +0100
Subject: [PATCH v3] platform: Make platform_bus device a platform device
In-Reply-To: <20140722221619.GA15781@kroah.com>
References: <20140722173713.GA8959@kroah.com>
 <1406051719-17354-1-git-send-email-pawel.moll@arm.com>
 <20140722221619.GA15781@kroah.com>
Message-ID: <1406125653.25343.141.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-07-22 at 23:16 +0100, Greg Kroah-Hartman wrote:
> On Tue, Jul 22, 2014 at 06:55:19PM +0100, Pawel Moll wrote:
> > ... describing the root of the device tree, so one can write
> > a platform driver initializing the platform.
> > 
> > There has been a lot of references to platform_bus device where
> > it didn't make any sense, because simply using NULL as a parent
> > will make the device be adopted by the top level anyway.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> > ---
> > Changes since v2:
> > 
> > * replaced references to platform_bus.dev with NULL
> >   in places where it shouldn't make any difference
> 
> How about split this up with just the "change to NULL" changes as one
> patch, and the rest as a second one?

Yes, was about to do exactly this.

Pawel
