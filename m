From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 22 Dec 2011 18:31:06 +0100
Subject: [PATCH v4 03/12] mfd: twl-core: Add initial DT support for
 twl4030/twl6030
In-Reply-To: <1324565806-31142-4-git-send-email-b-cousson@ti.com>
References: <1324565806-31142-1-git-send-email-b-cousson@ti.com>
 <1324565806-31142-4-git-send-email-b-cousson@ti.com>
Message-ID: <20111222173106.GJ5183@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Thu, Dec 22, 2011 at 03:56:37PM +0100, Benoit Cousson wrote:
> Add initial device-tree support for twl familly chips.
> The current version is missing the regulator entries due
> to the lack of DT regulator bindings for the moment.
> Only the simple sub-modules that do not depend on
> platform_data information can be initialized properly.
> 
> Add irqdomain support.
> 
> Add documentation for the Texas Instruments TWL Integrated Chip.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Graeme Gregory <gg@slimlogic.co.uk>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  .../devicetree/bindings/mfd/twl-familly.txt        |   47 ++++++++++++++++++
>  drivers/mfd/Kconfig                                |    1 +
>  drivers/mfd/twl-core.c                             |   51 +++++++++++++++++++-
>  3 files changed, 98 insertions(+), 1 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/twl-familly.txt
Patch applied instead of the previous one, thanks for the quick fix.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
