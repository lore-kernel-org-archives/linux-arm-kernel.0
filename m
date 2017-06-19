From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 19 Jun 2017 05:57:59 +0200
Subject: [PATCH v5 20/26] dt-bindings: power: Add Owl SPS power domains
In-Reply-To: <20170619033626.5583-1-afaerber@suse.de>
References: <20170606005426.26446-23-afaerber@suse.de>
 <20170619033626.5583-1-afaerber@suse.de>
Message-ID: <4a4cd31c-1d10-21d4-5f44-aa167dfab23c@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.06.2017 um 05:36 schrieb Andreas F?rber:
> Define power domains for all non-reserved S500 power gates.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v4 -> v5:
>  * Renamed header file with owl- prefix for uniqueness
>  
>  v3 -> v4: Unchanged
>  
>  v3: new
>  
>  .../devicetree/bindings/power/actions,owl-sps.txt     | 17 +++++++++++++++++
>  include/dt-bindings/power/owl-s500-powergate.h        | 19 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
>  create mode 100644 include/dt-bindings/power/owl-s500-powergate.h

Due to include dependency applying to linux-actions.git v4.13/soc:

https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
