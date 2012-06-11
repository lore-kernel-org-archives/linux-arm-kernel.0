From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jun 2012 14:58:05 +0000
Subject: [PATCH 8/14] ARM: LPC32xx: Clock adjustment for key matrix
 controller
In-Reply-To: <4FD60203.8010103@antcom.de>
References: <1339412537-24485-1-git-send-email-stigge@antcom.de>
 <201206111416.19251.arnd@arndb.de> <4FD60203.8010103@antcom.de>
Message-ID: <201206111458.05546.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, Roland Stigge wrote:
> On 06/11/2012 04:16 PM, Arnd Bergmann wrote:
> > On Monday 11 June 2012, Roland Stigge wrote:
> >> The clock.c file needs to be changed to match the automatic device name to its
> >> clock.
> >>
> >> Signed-off-by: Roland Stigge <stigge@antcom.de>
> >> Acked-by: Rob Herring <rob.herring@calxeda.com>
> >>
> > 
> > Should this not be in the same patch as the one that moves the device over
> > to DT probing? Otherwise you have a non-working setup if only one patch
> > is applied.
> 
> The actual driver is new for v3.6 (hopefully), DT-only.
> 
> Rather than merging the patches, I'd let the key driver go in via input,
> and the clock.c adjustment via arm-soc.

Ok, makes sense.

	Arnd
