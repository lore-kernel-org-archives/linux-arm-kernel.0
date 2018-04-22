From: vinod.koul@intel.com (Vinod Koul)
Date: Sun, 22 Apr 2018 11:47:33 +0530
Subject: [PATCH 07/61] dma: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-8-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-8-wsa+renesas@sang-engineering.com>
Message-ID: <20180422061733.GU6014@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 04:05:37PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.

Do you mind splitting this per driver please, that makes it easy to manage
for me :)

-- 
~Vinod
