From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Aug 2012 05:40:12 +0000
Subject: [PATCHv4 0/9] *** ARM: Update arch-vt8500 to Devicetree ***
In-Reply-To: <1345758702.2061.6.camel@gitbox>
References: <1345707346-9035-1-git-send-email-linux@prisktech.co.nz>
 <201208231322.23077.arnd@arndb.de> <1345758702.2061.6.camel@gitbox>
Message-ID: <201208240540.12316.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Tony Prisk wrote:
> I was about to say that if Mike has any issues with the driver that I
> can fix the patch conflict at the same time, but I just realised that
> its more work than I originally thought :)
> 
> I was going to move the arch-vt8500 part of the clocks patch back into
> the clocks patch - but that will just move the issue from arm-soc to
> clocks because Mike's branch won't have the arch-vt8500 patch so the
> patch will fail.

But that's ok, because without the arch-v8500 part, nothing uses
the vt8500-clock driver, so nothing breaks. You can introduce broken
code in the meantime as long as it's impossible to enable and it will
work afterwards.

	Arnd
