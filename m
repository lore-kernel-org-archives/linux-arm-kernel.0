From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 07 Sep 2015 10:49:00 +0200
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable DW USB2 support and
 rockchip phy
In-Reply-To: <55ED433A.5000907@samsung.com>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1441609832.8778.4.camel@collabora.co.uk> <55ED3BC5.8050603@samsung.com>
 <1447076.WCyUA0P2ql@diego> <55ED433A.5000907@samsung.com>
Message-ID: <1441615740.8778.15.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-09-07 at 16:56 +0900, Krzysztof Kozlowski wrote:
> On 07.09.2015 16:53, Heiko St?bner wrote:
> > Am Montag, 7. September 2015, 16:24:53 schrieb Krzysztof Kozlowski:
> > I guess the easiest option would be to just drop the dwc2 from
> > here, only 
> > keeping the phy enablement and let everything (Marek's and Sjoerd's
> > patch) 
> > come together in the armsoc defconfig branch? As the rest of both
> > patches don't 
> > seem to touch common areas, they should be easily mergable from
> > different trees 
> > as well.
> 
> Yes, I agree. The config PHY_ROCKCHIP_USB does not depend on it
> directly
> so this should work fine.

Sounds good, I'll wait a bit longer for more feedback and then send a
V2 with patch 4 adjusted to just enable the rockchip PHY.

Thanks for the feedback!

-- 
Sjoerd Simons
Collabora Ltd.
