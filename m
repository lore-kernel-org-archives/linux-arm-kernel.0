From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2016 15:09:41 +0530
Subject: [PATCH 2/2] ARM: davinci: PM: rework init: cleanup
In-Reply-To: <20161114230441.356-3-khilman@baylibre.com>
References: <20161114230441.356-1-khilman@baylibre.com>
 <20161114230441.356-3-khilman@baylibre.com>
Message-ID: <c8be7b69-551e-dd70-40d1-a36aa74aeb55@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 November 2016 04:34 AM, Kevin Hilman wrote:
> A follow-on cleanup renaming 'pdata' since it is no longer
> platform_data.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Looks good to me. Thanks for separating this out. Makes it much easier
to review.

In the subject line though, instead of just calling it cleanup, how
about a bit more descriptive statement like "remove references to pdata".

Thanks,
Sekhar
