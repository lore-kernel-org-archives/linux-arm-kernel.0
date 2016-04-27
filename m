From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Apr 2016 11:50:29 +0200
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <572081FB.5090303@arm.com>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <5591261.0X3WRSsdGl@wuerfel> <572081FB.5090303@arm.com>
Message-ID: <5212316.Wg9FOfdsuU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 April 2016 10:10:19 Vladimir Murzin wrote:
> > On the other hand, separating the two has the advantage of keeping it
> > simple, as we don't have to worry about all the ARMv7-A platforms
> > and whether we actually want to allow their kernels to be built with
> > MMU disabled.
> > 
> 
> Ok, what if we start with your approach explicitly saying which platform
> wants to be listed when CONFIG_MMU is deselected (I think R-class is the
> first user here) gradually extending such list with ARMv7-A? There is
> (little?) chance that at some point we can support kernel which can run
> on both configurations.

Do you mean adding a ARM_SINGLE_ARMV7R option, or ARCH_MULTI_V7R?

	Arnd
