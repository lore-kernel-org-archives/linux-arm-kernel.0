From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 16:16:07 -0400
Subject: [PATCH 1/4] ARM: Kirkwood: Add support for DLink DIR665
In-Reply-To: <20141101201139.GD11876@lunn.ch>
References: <1414793613-11798-1-git-send-email-andrew@lunn.ch>
 <1414793613-11798-2-git-send-email-andrew@lunn.ch>
 <20141101160309.GM15252@titan.lakedaemon.net>
 <20141101201139.GD11876@lunn.ch>
Message-ID: <20141101201607.GA2818@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 01, 2014 at 09:11:39PM +0100, Andrew Lunn wrote:
> > > +/* There is no battery on the boards, so the RTC does not keep time
> > > + * when there is now power, making it useless. */
> > 
> > Wow... so much for accurate logging.  At any rate, s/now/no/.  I'll fix
> > it up when I pull it in if there's nothing else.
> 
> Hi Jason
> 
> I assume the firmware use NTP, But strangely, there does appear to be
> a crystal, at least i assume there is since there is no error message
> at boot time about the clock not ticking. So it probably does keep
> time so long as the power is on. I did wonder if my board has a flat
> battery, but i cannot find a battery...

supercap?

thx,

Jason.
