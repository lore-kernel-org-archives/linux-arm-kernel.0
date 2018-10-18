From: robh@kernel.org (Rob Herring)
Date: Thu, 18 Oct 2018 15:42:24 -0500
Subject: [PATCH v2 04/10] firmware: ti_sci: Add RM mapping table for am654
In-Reply-To: <20181018154017.7112-5-lokeshvutla@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-5-lokeshvutla@ti.com>
Message-ID: <20181018204224.GA31136@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Oct 2018 21:10:11 +0530, Lokesh Vutla wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Add the resource mapping table for AM654 SoC as defined
> in http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
> Introduce a new compatible for AM654 "ti,am654-sci" for using
> this resource map table.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v1:
> - new patch added.
> 
>  .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
>  drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
