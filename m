From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 31 Jul 2015 08:30:03 -0700
Subject: [PATCH 2/2] ARM: dts: keystone: fix dt bindings to use post div
 register for mainpll
In-Reply-To: <1432915453-409-2-git-send-email-m-karicheri2@ti.com>
References: <1432915453-409-1-git-send-email-m-karicheri2@ti.com>
 <1432915453-409-2-git-send-email-m-karicheri2@ti.com>
Message-ID: <55BB947B.7090608@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

As discussed patch 1/2 is already made it via clock tree. Please
pick the subject fix for your upcoming fixes pull request.

On 5/29/2015 9:04 AM, Murali Karicheri wrote:
> All of the keystone devices have a separate register to hold post
> divider value for main pll clock. Currently the fixed-postdiv
> value used for k2hk/l/e SoCs works by sheer luck as u-boot happens to
> use a value of 2 for this. Now that we have fixed this in the pll
> clock driver change the dt bindings for the same.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
