From: davem@redhat.com (David Miller)
Date: Thu, 14 Aug 2014 14:39:11 -0700 (PDT)
Subject: [PATCH] net: xilinx: Remove .owner field for driver
In-Reply-To: <a63aa03f310bb32779833fc905579458a34be6ce.1407930852.git.michal.simek@xilinx.com>
References: <a63aa03f310bb32779833fc905579458a34be6ce.1407930852.git.michal.simek@xilinx.com>
Message-ID: <20140814.143911.339730226328001321.davem@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Simek <michal.simek@xilinx.com>
Date: Wed, 13 Aug 2014 13:54:22 +0200

> There is no need to init .owner field.
> 
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
> 
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Applied.
