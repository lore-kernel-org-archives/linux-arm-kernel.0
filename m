From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 23 Sep 2015 11:19:32 -0700
Subject: [PATCH 1/3] Documentation: dt: keystone: provide SoC specific
 compatible flags
In-Reply-To: <1442938118-4718-2-git-send-email-nm@ti.com>
References: <1442938118-4718-1-git-send-email-nm@ti.com>
 <1442938118-4718-2-git-send-email-nm@ti.com>
Message-ID: <5602ED34.9010108@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishant,

On 9/22/2015 9:08 AM, Nishanth Menon wrote:
> Keystone2 devices are used on more platforms than just Texas
> Instruments reference evaluation platforms called EVMs. Providing a
> generic compatible "ti,keystone" is not sufficient to differentiate
> various SoC definitions possible on various platforms. So, provide
> compatible matches for each SoC family by itself.
>
> This allows SoC specific logic to be run time handled based on
> of_machine_is_compatible("ti,k2hk") or as needed for the dependent
> processor instead of needing to use board dependent compatibles that
> are needed now.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
You need to expand that 'not sufficient' for me. Unless there is
genuine case to support this, I would want to avoid this churn.

Regards,
Santosh
