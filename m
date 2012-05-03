From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 May 2012 22:55:03 +0800
Subject: [PATCH 01/15] ARM: provide a late_initcall hook for platform
 initialization
In-Reply-To: <20120502131442.GA2194@S2101-09.ap.freescale.net>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-2-git-send-email-shawn.guo@linaro.org>
 <20120502131442.GA2194@S2101-09.ap.freescale.net>
Message-ID: <20120503145500.GH2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 09:14:44PM +0800, Shawn Guo wrote:
> On Wed, May 02, 2012 at 07:33:26PM +0800, Shawn Guo wrote:
> > This allows platforms to set up things that need to be done at
> > late_initcall time.
> > 
> > Cc: Russell King <linux@arm.linux.org.uk>
> 
> Hi Russell,
> 
> I think it's a bit easier to have this patch go through arm-soc tree
> together with other patches in the series.  May I have you ack on this
> patch to do that?
> 
Or you prefer to have this patch go to your patch tracker?  Please let
me know your preference.

-- 
Regards,
Shawn
