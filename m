From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 14:30:21 +0100
Subject: [PATCH] ARM: dts: hip04: move bootwrapper to SRAM
In-Reply-To: <54B4F48B.6020206@suse.de>
References: <54B48D5E.6050902@hisilicon.com> <54B4F350.5040007@hisilicon.com>
 <54B4F48B.6020206@suse.de>
Message-ID: <5729331.m4QfoTlcib@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 11:33:47 Alexander Graf wrote:
> 
> The "real" solution to all of this would be proper PSCI calls, but I'd
> rather not be the one implementing all of the frameworks for it :). And
> I'm not it's worth the effort for a 32bit platform that basically works
> now with bootwrapper living in SRAM.
> 

That would still leave the same problem, since we'd still need to deal
with old firmware that does not have PSCI.

	Arnd
