From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 May 2012 11:03:38 +0100
Subject: [PATCH] serial/of-serial: Add 16654 chip to compatible string list
In-Reply-To: <1338199134-23885-1-git-send-email-stigge@antcom.de>
References: <1338199134-23885-1-git-send-email-stigge@antcom.de>
Message-ID: <20120528100338.GI24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 11:58:54AM +0200, Roland Stigge wrote:
> The (ST)16654 chip was missing in the list of supported chips in of-serial.
> This patch adds the string "st16654" to it, and to the documentation.

Something which occurs to me.  Normally, the digit at the end indicates
how many ports are integrated into the device (0=1port, 2=2port, 4=4port.)
Are you sure there isn't a ST16650 which has the same characteristics?

We really should stick with naming these using the single port versions if
at all possible.
