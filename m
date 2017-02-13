From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 13 Feb 2017 15:35:16 +0100
Subject: [PATCH 1/2] [media] exynos-gsc: Do not swap cb/cr for semi planar
 formats
In-Reply-To: <1485979523-32404-2-git-send-email-javier@osg.samsung.com>
References: <1485979523-32404-1-git-send-email-javier@osg.samsung.com>
 <1485979523-32404-2-git-send-email-javier@osg.samsung.com>
 <CGME20170213143524epcas5p1e1fdcf49d5fd9b0c40cc9ffe849f10d9@epcas5p1.samsung.com>
Message-ID: <983a36ab-bcba-b51d-6078-5d020b47b8d1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2017 09:05 PM, Javier Martinez Canillas wrote:
> From: Thibault Saunier <thibault.saunier@osg.samsung.com>
> 
> In the case of semi planar formats cb and cr are in the same plane
> in memory, meaning that will be set to 'cb' whatever the format is,
> and whatever the (packed) order of those components are.
> 
> Suggested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Thibault Saunier <thibault.saunier@osg.samsung.com>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
