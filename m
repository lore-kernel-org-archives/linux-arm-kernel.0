From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 16 Apr 2012 20:13:11 +0200
Subject: [PATCH v4] mfd: da9052: add device-tree support for i2c driver
In-Reply-To: <1334505710-8919-1-git-send-email-paul.liu@linaro.org>
References: <1334505710-8919-1-git-send-email-paul.liu@linaro.org>
Message-ID: <20120416181311.GW24130@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Mon, Apr 16, 2012 at 12:01:50AM +0800, Ying-Chun Liu (PaulLiu) wrote:
> From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> 
> This patch adds device-tree support for dialog MFD and the binding
> documentations.
> 
> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Ashish Jangam <ashish.jangam@kpitcummins.com>
> ---
>  .../devicetree/bindings/mfd/da9052-i2c.txt         |   60 ++++++++++++++++++++
>  drivers/mfd/da9052-i2c.c                           |   50 +++++++++++++---
>  2 files changed, 102 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9052-i2c.txt
Patch applied to my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
