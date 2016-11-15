From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 15 Nov 2016 11:39:09 -0800
Subject: [PATCH 2/2] ARM: davinci: PM: rework init: cleanup
In-Reply-To: <c8be7b69-551e-dd70-40d1-a36aa74aeb55@ti.com> (Sekhar Nori's
 message of "Tue, 15 Nov 2016 15:09:41 +0530")
References: <20161114230441.356-1-khilman@baylibre.com>
 <20161114230441.356-3-khilman@baylibre.com>
 <c8be7b69-551e-dd70-40d1-a36aa74aeb55@ti.com>
Message-ID: <m2oa1gy1lu.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sekhar Nori <nsekhar@ti.com> writes:

> On Tuesday 15 November 2016 04:34 AM, Kevin Hilman wrote:
>> A follow-on cleanup renaming 'pdata' since it is no longer
>> platform_data.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Looks good to me. Thanks for separating this out. Makes it much easier
> to review.
>
> In the subject line though, instead of just calling it cleanup, how
> about a bit more descriptive statement like "remove references to pdata".

Sure.  respin coming right up.

Kevin
