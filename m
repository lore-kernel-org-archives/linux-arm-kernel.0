From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Feb 2012 14:34:08 -0800
Subject: [PATCH 0/3] Move most of omap io.h into omap-iomap.h
In-Reply-To: <20120214171816.GN1426@atomide.com>
References: <20120213235216.26087.66303.stgit@kaulin.local>
 <20120214171816.GN1426@atomide.com>
Message-ID: <20120221223408.GS18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120214 08:47]:
> * Tony Lindgren <tony@atomide.com> [120213 15:22]:
> > Hi all,
> > 
> > This is intended as clean-up before we apply Rob Herring's series
> > to remove mach/io.h.
> 
> Need to update this to fix up more driver modules though.

Also we can move almost everything into local iomap.h files.

So let's scrap this series, I will post a new series shortly.

Regards,

Tony
