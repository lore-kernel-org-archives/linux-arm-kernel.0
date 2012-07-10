From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jul 2012 13:41:35 +0000
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <20120710121944.GA17661@elf.ucw.cz>
References: <20120710094249.GF10225@elf.ucw.cz> <20120710112448.GA4806@page>
 <20120710121944.GA17661@elf.ucw.cz>
Message-ID: <201207101341.36178.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 July 2012, Pavel Machek wrote:
> Move dw-apb devicetree bindings code to drivers/clocksource, so it can
> be easily shared between picoxcell and socfpga. 
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>

I agree with the patch, but please make it easier to review, either by
using the "-M" flag to git format-patch, or by splitting it into one
patch that holds the changes inside that file and another patch that
moves it.

	Arnd
