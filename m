From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 18 Apr 2011 12:18:07 +0800
Subject: [RFC 0/4] convert stmp into mxs and delete the obsolete platform
In-Reply-To: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
References: <1303093838-23959-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110418041806.GB18623@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Apr 18, 2011 at 04:30:34AM +0200, Wolfram Sang wrote:
> I tried a smaller scaled cleanup before, but now that there are talks about ARM
> consolidation everywhere, I'll be more brave :)
> 
> What we have here is consolidation of two platforms. The older one, plat-stmp,
> has never seen much love after the initial commit and has poor design as stated
> in the patch descriptions. The recently added mach-mxs can be used for a
> (friendly) takeover. Adding 130 lines there could save 9500+ lines in arch/arm!
> 
> The drawback sofar is getting an ack from the old submitters of the code. I
> tried contacting Dmitry and a generic address at EmbeddedAlley and they were
> all bounced. However, while EmbeddedAlley was bought by Mentor, also Sigmatel
> was bought by Freescale. I guess Freescale does have more interest in the code
> than Mentor, so I'll try adding Shawn Guo to CC and hope for his ack.
> 
You are doing something that I have been intending to do for some
while.  I think you are doing the right thing at the right time ;)
Let me know if you need any help.

Acked-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn
