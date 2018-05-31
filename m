From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 23:08:32 -0500
Subject: [PATCH v2 4/6] bus: ti-sysc: Add support for using ti-sysc for
 MCAN on dra76x
In-Reply-To: <20180530141133.3711-5-faiz_abbas@ti.com>
References: <20180530141133.3711-1-faiz_abbas@ti.com>
 <20180530141133.3711-5-faiz_abbas@ti.com>
Message-ID: <20180531040832.GA30763@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 07:41:31PM +0530, Faiz Abbas wrote:
> The dra76x MCAN generic interconnect module has a its own
> format for the bits in the control registers.
> 
> Therefore add a new module type, new regbits and new capabilities
> specific to the MCAN module.
> 
> CC: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/bus/ti-sysc.txt         |  1 +
>  drivers/bus/ti-sysc.c                           | 17 +++++++++++++++++
>  include/dt-bindings/bus/ti-sysc.h               |  2 ++
>  include/linux/platform_data/ti-sysc.h           |  1 +
>  4 files changed, 21 insertions(+)

For the DT bits:

Acked-by: Rob Herring <robh@kernel.org>
