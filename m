From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 6 Oct 2012 14:42:22 +0100
Subject: redirecting console output to display
In-Reply-To: <1349109542.85942.YahooMailNeo@web133201.mail.ir2.yahoo.com>
References: <1349109542.85942.YahooMailNeo@web133201.mail.ir2.yahoo.com>
Message-ID: <20121006134222.GA25755@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 05:39:02PM +0100, Ellis Andrew wrote:
> The kernel shows a message "disabling irom" and then the screen is disabled.

No idea what that message is.

> How can I set up my kernel so that it enables the display and outputs a
> console on tty0?

The default (without any console= arguments) and with fbcon enabled is to
output to the framebuffer console.  There is no difference in this regard
between running Linux on ARM and running Linux on a PC with a framebuffer
console.
