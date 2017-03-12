From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 12 Mar 2017 10:21:17 -0700
Subject: [PATCH v4 3/5] dt-bindings: Add TI SCI PM Domains
In-Reply-To: <1488882154-21485-4-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-4-git-send-email-d-gerlach@ti.com>
Message-ID: <0a3e4ac3-d541-8d0d-c598-91c9f71cbc39@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/17 2:22 AM, Dave Gerlach wrote:
> Add a generic power domain implementation, TI SCI PM Domains, that
> will hook into the genpd framework and allow the TI SCI protocol to
> control device power states.
>
> Also, provide macros representing each device index as understood
> by TI SCI to be used in the device node power-domain references.
> These are identifiers for the K2G devices managed by the PMMC.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
