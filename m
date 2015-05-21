From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 15:24:02 +0200
Subject: [Linaro-acpi] [V4 PATCH 1/6] ACPI / scan: Parse _CCA and setup
 device coherency
In-Reply-To: <20150521130116.GJ29424@e104818-lin.cambridge.arm.com>
References: <1431724994-21601-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <5074701.G8z7gpKvin@wuerfel>
 <20150521130116.GJ29424@e104818-lin.cambridge.arm.com>
Message-ID: <3038248.bRme3FQvei@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 14:01:16 Catalin Marinas wrote:
> On Wed, May 20, 2015 at 02:04:02PM +0200, Arnd Bergmann wrote:
> > On Wednesday 20 May 2015 06:52:03 Suravee Suthikulanit wrote:
> > > 
> > > Ok. That seems to be what Arnd would prefer as well.  Let's just leave 
> > > the support for _CCA=0 out until it is needed then.
> > 
> > Yes, that would be best (as I said repeatedly  )
> 
> I'm sure it won't be long before someone asks for this feature ;).

If nothing else, we get to publically shame them for building crappy
hardware then ;-)

	Arnd
