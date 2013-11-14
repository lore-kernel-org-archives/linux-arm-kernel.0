From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Nov 2013 09:34:29 -0800
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
In-Reply-To: <20131114065830.GA2738@katana>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
 <20131114065830.GA2738@katana>
Message-ID: <20131114173429.GF10317@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wolfram Sang <wsa@the-dreams.de> [131113 22:59]:
> On Wed, Nov 13, 2013 at 06:35:33PM -0800, Tony Lindgren wrote:
> > As we claim to support device tree for mach-omap2, we
> > should have the necessary flags in the driver to make it
> > usable.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c at vger.kernel.org
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> 
> It would have been helpful if the message "PATCH [0/x]" would have been
> sent to the i2c-list also.

Thanks, next time I'll try check the cc list in the cover letter
manually after running git format patch. I guess there's no way
to deal with that in an automated way.

Here's a link to the whole thread for reference:

http://www.spinics.net/lists/arm-kernel/msg286246.html
