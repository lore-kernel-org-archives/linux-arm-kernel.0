From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 20 May 2011 15:49:09 +0200
Subject: [PATCH V4] OMAP3+: SR Layer Cleanup
In-Reply-To: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
References: <1305268062-20046-1-git-send-email-shweta.gulati@ti.com>
Message-ID: <4DD67155.1030705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shweta,

On 5/13/2011 8:27 AM, Gulati, Shweta wrote:
> To set sr ntarget values  for all volt_domain,
> volt_table is retrieved by doing a look_up of 'vdd_name'
> field from omap_hwmod but voltage domain pointer does not
> belong to omap_hwmod and is not used anywhere else.
> As a part of voltage layer and SR Layer clean up volt
> pointer is removed from omap_hwmod and added in dev
> attributes of SR.
>
> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>
> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
> Acked by: Nishanth Menon<nm@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> ---
>
> V4:
>    Fixed comments like checking for NULL pointers
>    and following conventions in naming the instances
>    recommended by Todd Poynor and Benoit Cousson.

It looks like you missed at least two comments I did on the previous 
version whereas you did agree to fix them.

Thanks,
Benoit
