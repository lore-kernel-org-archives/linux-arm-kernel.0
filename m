From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 20:31:50 +0100
Subject: Known issues with amba-pl010.c driver?
In-Reply-To: <0D753D10438DA54287A00B0270842697636F1BC928@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636F1BC928@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100521193150.GF11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 07:22:12PM -0500, H Hartley Sweeten wrote:
> Are there any known issues with the amba-pl010.c driver?

I'm not aware of any problems with it.  It was used on ARM's early
Integrator platforms, but not their later ones having been superseded
by the PL011 primecell.

> I see a similar pause when using one of the other serial ports as a
> console.  When doing something that spews a lot of data to the port
> the delays are very noticeable.  For instance the command:

How long are these delays?
