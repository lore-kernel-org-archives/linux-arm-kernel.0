From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 27 Apr 2012 18:39:07 -0600 (MDT)
Subject: [PATCH-V4 1/4] ARM: OMAP3+: am33xx: Add voltage domain data
In-Reply-To: <1333123435-27186-2-git-send-email-hvaibhav@ti.com>
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <1333123435-27186-2-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204271838090.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav, Kevin,

On Fri, 30 Mar 2012, Vaibhav Hiremath wrote:

> Currently dummy voltage domain data is being created
> in order to succeed boot process, nothing has been done
> w.r.t actual hardware (voltage control).
> 
> Also, hook up the AM33XX voltage domain to OMAP framework.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rajendra Nayak <rnayak@ti.com>

Looks okay to me.  Kevin, you want to ack this one and I will queue it?  
Either that, or if you want to take it, I will ack it.


- Paul
