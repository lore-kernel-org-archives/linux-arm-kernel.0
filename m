From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:43:56 -0700 (MST)
Subject: [PATCH 0/5] OMAP3&4: Fixes in setup/suspend/powerdomain
In-Reply-To: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
References: <1292276969-29733-1-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012132342030.15971@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Beno?t, Kevin,

On Mon, 13 Dec 2010, Benoit Cousson wrote:

> This is a series of fixes on OMAP3/4 in setup apis,
> in the suspend framework and in powerdomain modelling
> for OMAP4.

...

> Rajendra Nayak (3):
>   OMAP4: PM: Use the lowpwrstatechange feature on OMAP4
>   OMAP4: PM: Do not assume clkdm supports hw transitions

The above two patches should be run by Kevin for his ack (cc'ed on this 
message).  Kevin, care to ack these?



- Paul
