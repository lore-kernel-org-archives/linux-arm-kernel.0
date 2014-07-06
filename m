From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 6 Jul 2014 00:32:07 +0000 (UTC)
Subject: [PATCH] ARM: DRA7: hwmod: add entry for RTCSS
In-Reply-To: <53B52EEC.2030800@ti.com>
References: <f99196358a3cc28b0bd451459badcfc286533845.1399638849.git.nsekhar@ti.com>
 <53B52EEC.2030800@ti.com>
Message-ID: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Jul 2014, Rajendra Nayak wrote:

> On Friday 09 May 2014 06:07 PM, Sekhar Nori wrote:
> > From: Lokesh Vutla <lokeshvutla@ti.com>
> > 
> > RTCSS on DRA7 provides a precise real-time clock.
> > Add hwmod entry for this IP.
> > 
> > Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> 
> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
> 
> > ---
> > Applies to linux-next of 5th May.
> 
> Might need a repost with rebase on the latest mainline.

Will queue this as soon as someone sends a Tested-by: & a boot log for it.


- Paul
