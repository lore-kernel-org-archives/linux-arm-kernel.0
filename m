From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 12 Mar 2010 11:25:04 +0000
Subject: Question about memory resources
In-Reply-To: <0D753D10438DA54287A00B0270842697636843779C@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636843779C@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100312112504.GC23739@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 11, 2010 at 04:48:45PM -0600, H Hartley Sweeten wrote:

> Is there any way to handle this other than using the static i/o
> mapping for the backlight register?

The standard thing would be a MFD, or a single driver that exports both
interfaces.
