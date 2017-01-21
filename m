From: robh@kernel.org (Rob Herring)
Date: Sat, 21 Jan 2017 14:02:29 -0600
Subject: [PATCH 2/3] Documentation: devicetree: amlogic: Add R-Box Pro
In-Reply-To: <20170117225459.4438-2-afaerber@suse.de>
References: <20170117030611.23827-2-afaerber@suse.de>
 <20170117225459.4438-1-afaerber@suse.de>
 <20170117225459.4438-2-afaerber@suse.de>
Message-ID: <20170121200229.b7j3bumq4bd6u5jk@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 11:54:58PM +0100, Andreas F?rber wrote:
> Cc: ada at kingnoval.com
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  Originally I thought we would group by SoC (6, 8, 8b, gxbb, gxl, gmx, etc.)
>  but this got out of order with nexbox,a95x - so inserting kingnovel between
>  amlogic and nexbox here. If that's what we want going forward, we should move
>  the old entries to make the scheme clearer. The alternative would be to
>  reorder alphabetically within each SoC group, but nexbox,a95x with two SoCs
>  makes it difficult to categorize, we could choose gxbb as the earlier one.
>  
>  Documentation/devicetree/bindings/arm/amlogic.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
