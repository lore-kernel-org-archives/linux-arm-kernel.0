From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 2 Jun 2011 12:54:55 +0300
Subject: [PATCH v3] ARM: ep93xx: use more reliable CPLD watchdog for
	reset on ts72xx
In-Reply-To: <1306868578-3883-1-git-send-email-ynezz@true.cz>
References: <ADE657CA350FB648AAC2C43247A983F001F381FC4955@AUSP01VMBX24.collaborationhost.net>
	<1306868578-3883-1-git-send-email-ynezz@true.cz>
Message-ID: <20110602095455.GB2954@acer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 09:02:58PM +0200, Petr ?tetiar wrote:
> On all ep93xx based boards from Technologic Systems, there's CPLD watchdog
> available, so use this one to reset the board instead of the soft reset in
> CPU.  I've seen some weird lockups with the soft reset on ep93xx in the past,
> while the reset via CPLD watchdog seems to be rock solid (tm) and works fine
> so far.

Where can I find the whole series? I was going to test this on my TS-7260 but
I only found this patch from my inbox and it doesn't apply without the
previous one :-(
