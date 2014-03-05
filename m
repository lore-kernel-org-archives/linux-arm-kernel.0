From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Mar 2014 11:33:26 -0800
Subject: [PATCHv3 00/13] OMAP IOMMU DT adaptation for 3.15
In-Reply-To: <5316068F.3020003@ti.com>
References: <1393620164-14633-1-git-send-email-s-anna@ti.com>
 <20140228230000.GW13624@atomide.com>
 <20140304160432.GG2799@8bytes.org> <5316068F.3020003@ti.com>
Message-ID: <20140305193326.GA7599@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Suman Anna <s-anna@ti.com> [140304 09:03]:
> On 03/04/2014 10:04 AM, Joerg Roedel wrote:
> >
> >Applied patches 1-7 to my arm/omap branch.
> >
> >Tony, you can pull that branch into your tree if needed (when I pushed
> >it, which will happen today or tomorrow).

OK thanks, looks like remaining patches compile just fine even without
it which is nice.

> Tony,
> Can you also pull in the corresponding DTS node patches as well that
> go along with this series.
> http://marc.info/?l=linux-omap&m=139362062805816&w=2

They look OK to me, but looks like Benoit and Paul are not Cc:ed
on the hwmod changes. I suggest you resend just patches 8 - 13 and
the .dts changes as a new series with Benoit and Paul on Cc for
them so they have a chance to review and ack them.

Regards,

Tony
