From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 23 Nov 2016 09:47:57 +0530
Subject: [PATCH] dmaengine: qcom_hidma: autoload while probing ACPI
In-Reply-To: <1479583718-2716-1-git-send-email-okaya@codeaurora.org>
References: <1479583718-2716-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20161123041756.GG2698@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 02:28:37PM -0500, Sinan Kaya wrote:
> MODULE_DEVICE_TABLE is used by the kernel to determine which device driver
> should be loaded for which platform device. MODULE_DEVICE_TABLE has been
> only defined for the device-tree based platforms in the current code.
> Defining it also for ACPI based platforms.

Applied now

-- 
~Vinod
