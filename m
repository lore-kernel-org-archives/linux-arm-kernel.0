From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 9 Jun 2017 09:37:37 +0200
Subject: [PATCH v5 4/5] arm64: dts: exynos: Remove the OF graph from DSI
 node
In-Reply-To: <ac8dc366-4273-9e24-a60e-ece22a6ad5bc@samsung.com>
References: <1488948852-5380-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308045502epcas1p21a483d429e2169b322e40fd833c47f27@epcas1p2.samsung.com>
 <1488948852-5380-5-git-send-email-hoegeun.kwon@samsung.com>
 <20170515164829.rfcqj5quw2jooh6u@kozik-lap>
 <9508dfc9-7cd3-3ed3-f642-2f69a5dcb5ce@samsung.com>
 <ac8dc366-4273-9e24-a60e-ece22a6ad5bc@samsung.com>
Message-ID: <20170609073737.GC4018@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 03:14:20PM +0900, Hoegeun Kwon wrote:
> On 05/19/2017 03:17 PM, Hoegeun Kwon wrote:
> >On 05/16/2017 01:48 AM, Krzysztof Kozlowski wrote:
> >>On Wed, Mar 08, 2017 at 01:54:11PM +0900, Hoegeun Kwon wrote:
> >>>The OF graph is not needed because the panel is a child of dsi. Remove
> >>>the ports node in DSI node.
> >>>
> >>>Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> >>>Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> >>>Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
> >>>---
> >>>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 14
> >>>--------------
> >>>  1 file changed, 14 deletions(-)
> >>>
> >>Hi,
> >>
> >>I wanted to apply this (and 5/5) but it seems that DRM change is not
> >>merged. Was it included in v4.12-rc1?
> >>
> >>Best regards,
> >>Krzysztof
> >
> >Hi,
> >
> >Sorry for my belated reply.
> >
> >The DRM patch(3/5) is not merged in v4.12-rc1 (mainline)...
> >I have checked the David's branch, but not merged.
> >However it was merged into Inki's exynos drm branch.
> >
> >Inki, Could you check the patch(3/5).
> >
> >Best regards,
> >Hoegeun
> 
> Hi Krzysztof,
> 
> The drm patch(3/5) has been merged into v4.12-rc4.

Thanks for letting me know. My branch is rebased on v4.12-rc1 so to
maintain bisectabiltiy I would have to merge v4.12-rc4... thus making a
messy history.

It is just a cleanup so I will take it after releasing v4.12, so this
will end up in v4.14. No need to resend, I'll keep it in Patchwork.

Best regards,
Krzysztof
