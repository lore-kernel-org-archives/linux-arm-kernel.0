From: pavel@denx.de (Pavel Machek)
Date: Tue, 10 Jul 2012 20:08:01 +0200
Subject: Move designware timer OF glue into drivers/clocksource
In-Reply-To: <201207101341.36178.arnd@arndb.de>
References: <20120710094249.GF10225@elf.ucw.cz> <20120710112448.GA4806@page>
 <20120710121944.GA17661@elf.ucw.cz>
 <201207101341.36178.arnd@arndb.de>
Message-ID: <20120710180801.GA14804@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2012-07-10 13:41:35, Arnd Bergmann wrote:
> On Tuesday 10 July 2012, Pavel Machek wrote:
> > Move dw-apb devicetree bindings code to drivers/clocksource, so it can
> > be easily shared between picoxcell and socfpga. 
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> I agree with the patch, but please make it easier to review, either by
> using the "-M" flag to git format-patch, or by splitting it into one
> patch that holds the changes inside that file and another patch that
> moves it.

Well, I did not do any significant changes, just removed the
prefix. Anyway, will do -M in my next reply.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
