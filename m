From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Dec 2010 23:39:05 +0000
Subject: [PATCH v4] mach-at91: Support for gsia18s board added
In-Reply-To: <1292183570.8737.33.camel@homepc>
References: <1292000411-6691-1-git-send-email-plyatov@gmail.com>
	<20101212005048.GH19897@game.jcrosoft.org>
	<1292135848.2456.19.camel@homepc>
	<20101212140727.GI19897@game.jcrosoft.org>
	<20101212142200.GG8665@n2100.arm.linux.org.uk>
	<1292183570.8737.33.camel@homepc>
Message-ID: <20101212233905.GJ8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 12, 2010 at 10:52:50PM +0300, Igor Plyatov wrote:
> Just to clarify: my gsia18s machine number will be added into
> linux-2.6.37-rc6?

That depends on the timing of my next pull request.  I don't have that
much queued for the -rc at present, so I may skip sending stuff for rc6.
It will be in before the next merge window now though, and idIt'll be
queued in linux-next nevertheless.

> Russel, please fix it to more readable "gsia18s" and "*_GSIA18S" for my
> 3234 machine.
> Old names with two underscores ("gs_ia18_s" and "*_GS_IA18_S") was very
> hard to read in the source code.

Fixed, inspite of the spelling error above.  Grr.
