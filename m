From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 12 Mar 2017 10:20:22 -0700
Subject: [PATCH v4 5/5] ARM: keystone: Drop PM domain support for k2g
In-Reply-To: <1488882154-21485-6-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-6-git-send-email-d-gerlach@ti.com>
Message-ID: <4c1a6b75-357a-a02d-acfe-046a5ab913db@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/17 2:22 AM, Dave Gerlach wrote:
> K2G will use a different power domain driver than the rest of the
> keystone family in order to make use of the TI SCI protocol so prevent
> the standard keystone pm_domain code from registering itself in
> preparation for a new driver.
>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
