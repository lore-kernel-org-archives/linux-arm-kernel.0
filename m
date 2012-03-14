From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Mar 2012 21:45:39 +0800
Subject: [PATCH 4/7] dt/clock: Add handling for fixed clocks and a clock
 node setup iterator
In-Reply-To: <4F609C79.2060307@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-5-git-send-email-robherring2@gmail.com>
 <20120314075930.GF21337@S2101-09.ap.freescale.net>
 <4F609C79.2060307@gmail.com>
Message-ID: <20120314134535.GH21337@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 08:26:17AM -0500, Rob Herring wrote:
...
> It also only works for root fixed clocks, but the common clock allows
> for non-root fixed clocks. I don't think there's much use case for that
> at least as a DT clock node.
> 
What my example demonstrates are root fixed clocks.

-- 
Regards,
Shawn
