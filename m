From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 Jan 2013 09:59:40 -0800
Subject: [PATCH V2 2/2] ARM: dts: OMAP2+: Add PMU nodes
In-Reply-To: <50F01AAD.8020003@ti.com>
References: <1355766548-5702-1-git-send-email-jon-hunter@ti.com>
 <1355766548-5702-3-git-send-email-jon-hunter@ti.com>
 <50F01256.7030701@ti.com> <50F01AAD.8020003@ti.com>
Message-ID: <20130111175939.GL14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130111 06:02]:
> Hi Benoit,
> 
> On 01/11/2013 07:23 AM, Benoit Cousson wrote:
> > Hi Jon,
> > 
> > On 12/17/2012 06:49 PM, Jon Hunter wrote:
> >> Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.
> >>
> >> Please note that the node for OMAP4460 has been placed in a separate
> >> header file for OMAP4460, because the node is not compatible with
> >> OMAP4430. The node for OMAP4430 is not included because PMU is not
> >> currently supported on OMAP4430 due to the absence of a cross-trigger
> >> interface driver.
> >>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> > 
> > I've just applied this patch in my for_3.9/dts branch.
> > 
> > I'm wondering if there is any dependency with the previous patch? If
> > Tony ack it I can take it as well.
> 
> I have been thinking about the best way to handle that. May be best for
> you to take both if Tony can ack the first.

Sounds good to me, I've acked it now.

Tony
