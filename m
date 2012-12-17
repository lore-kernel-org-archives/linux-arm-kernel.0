From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 17 Dec 2012 09:13:06 +0100
Subject: [PATCH v4 16/23] ARM: OMAP2+: clock data: Merge utmi_px_gfclk
 into usb_host_hs_utmi_px_clk
In-Reply-To: <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
References: <1355134833-5199-1-git-send-email-rogerq@ti.com>
 <1355134833-5199-17-git-send-email-rogerq@ti.com>
 <20121214182855.GB4989@atomide.com>
 <alpine.DEB.2.00.1212141838130.5915@utopia.booyaka.com>
Message-ID: <50CED412.7060407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 12/14/2012 07:44 PM, Paul Walmsley wrote:
> Hi
> 
> On Fri, 14 Dec 2012, Tony Lindgren wrote:
> 
>> Paul, what about this patch? Looks like you've acked the other clock 
>> patches in this series but not this one?
> 
> I commented on it briefly here:
> 
> https://patchwork.kernel.org/patch/1838111/
> 
> Maybe Beno?t could comment here, but it looks to me (based on a 
> superficial look at the hardware clock tree data) that these clock nodes 
> should exist.  In an ideal world, we'd be able to get back to the 
> autogeneration of this clock data.

I'm not sure to understand either the rational for that patch. What the
point of merging the two nodes?
I mean, we can do it, but AFAIR, we have always decided to use atomic
node instead of big nodes that handle everything.

Regards,
Benoit
