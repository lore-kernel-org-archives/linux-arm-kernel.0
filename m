From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 14 Oct 2013 16:50:12 -0400 (EDT)
Subject: [PATCH 05/11] USB: OHCI: Properly handle ohci-ep93xx suspend
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8817DABD8C@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <Pine.LNX.4.44L0.1310141647140.6851-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Oct 2013, Hartley Sweeten wrote:

> Alan,
> 
> As an alternative to this patch, I have successfully used the ohci-platform
> driver on the ep93xx. This does move a bit of glue code into the ep93xx
> core (arch/arm/mach-ep93xx/core.c) but it removes the ohci-ep93xx glue
> driver completely.
> 
> I can post a patch for this shortly if you would like.

That would be great!  It would save me the trouble of fixing 
Manjanuth's patch and it would remove a source file too!

Alan Stern
