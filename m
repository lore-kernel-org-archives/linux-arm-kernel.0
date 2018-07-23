From: nm@ti.com (Nishanth Menon)
Date: Mon, 23 Jul 2018 08:33:03 -0500
Subject: [PATCH V2 0/2] firmware: ti_sci: Add host-id as an optional
 parameter
In-Reply-To: <20180716171328.11674-1-nm@ti.com>
References: <20180716171328.11674-1-nm@ti.com>
Message-ID: <20180723133303.ijekyffgnmesrhhv@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:13-20180716, Nishanth Menon wrote:
> Please find attached series to enable host-id as an optional dt property.
> 
> This is a minor update to V1 -> Mostly to pick up Greet's feedback and Rob's Ack.
> 
> V1: https://patchwork.ozlabs.org/cover/931822/
> 
> The series is based on v4.18-rc1 and is available here:
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-tisci
> 
> Consolidated all patches (including all series) are available here:
> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ
> 
> Full Boot log (integrated of all series for AM654) is available here:
>    https://pastebin.ubuntu.com/p/bBFmnzYtCd/
> 
> Nishanth Menon (2):
>   Documentation: dt: keystone: ti-sci: Add optional host-id parameter
>   firmware: ti_sci: Provide host-id as an optional dt parameter
> 
>  .../devicetree/bindings/arm/keystone/ti,sci.txt    |  4 ++++
>  drivers/firmware/ti_sci.c                          | 24 ++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)

Santosh,

Apologies, I see you have already send your PR for v4.19. Was
just wondering if this is something we can consider for rc
cycle OR if you'd consider a followup PR for the same.

-- 
Regards,
Nishanth Menon
