From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 24 May 2012 14:02:02 -0600 (MDT)
Subject: [PATCH 0/4] omap legacy full speed usb cleanup for v3.6
In-Reply-To: <20120521185323.927.88012.stgit@muffinssi.local>
References: <20120521185323.927.88012.stgit@muffinssi.local>
Message-ID: <alpine.DEB.2.00.1205241401070.2572@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 May 2012, Tony Lindgren wrote:

> This series removes the old legacy fulls speed support for
> omap2 as it's pretty much only used for omap1 only.
> 
> For omap2, only n8x0 seems to have active development, and
> that has the external high speed tusb chip instead.

Just FYI, full speed host USB exists on OMAP4.  It's in section 23.13 of 
the TRM and we have a hwmod for it.  No idea if anyone is actually using 
it.


- Paul
