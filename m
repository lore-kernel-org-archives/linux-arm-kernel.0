From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 15 Nov 2013 20:49:46 +0200
Subject: [PATCH 9/8] i2c: Fix device tree binding for i2c-cbus-gpio
In-Reply-To: <20131114230842.GU10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <20131114230842.GU10317@atomide.com>
Message-ID: <20131115184946.GB10997@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 14, 2013 at 03:08:42PM -0800, Tony Lindgren wrote:
> Looks like we're missing two lines needed to make it
> work properly with device tree.
> 
> Cc: linux-i2c at vger.kernel.org
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

You can change this to: Tested-by: <aaro.koskinen@iki.fi>

I booted DT-N800 with Tony's patches, and it works.

Thanks,

A.
