From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Thu, 20 Jul 2017 11:53:53 -0700
Subject: [PATCH v2] dt-bindings: Drop k2g genpd device ID macros
In-Reply-To: <20170720180403.14279-1-d-gerlach@ti.com>
References: <20170720180403.14279-1-d-gerlach@ti.com>
Message-ID: <4beacba1-26f7-a4a4-9b1d-e3eb3db44b25@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/20/2017 11:04 AM, Dave Gerlach wrote:
> Commit 7cc119f29b19 ("dt-bindings: Add TI SCI PM Domains") introduced a
> number of K2G_DEV_x macros to represent each device ID available on the
> K2G platform for use by the genpd, clock, and reset drivers. Rather than
> use these macros, which are only used in the device tree for property
> values and not actually used by the drivers, let's just use the device
> ID number directly in the device tree to avoid macro bloat.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> Santosh, Resend of https://www.spinics.net/lists/devicetree/msg177717.html
> rebased on v4.13-rc1 and with Rob's ack included, unchanged otherwise and
> ready for merge.
>
Adding to the queue. Thanks Dave !!
