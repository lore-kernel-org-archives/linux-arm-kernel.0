From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jun 2017 10:02:32 -0700
Subject: [PATCH v4 07/11] net: mvmdio: check the MII_ADDR_C45 bit is not
 set for smi operations
In-Reply-To: <20170614154911.14510-8-antoine.tenart@free-electrons.com>
References: <20170614154911.14510-1-antoine.tenart@free-electrons.com>
 <20170614154911.14510-8-antoine.tenart@free-electrons.com>
Message-ID: <326e1b80-be39-3fcc-ec3d-9fdfe6fc213e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2017 08:49 AM, Antoine Tenart wrote:
> Add a check for the read and write smi operations, to ensure the
> MII_ADDR_C45 bit isn't set. This will be needed as soon as the xSMI
> support is added to the mvmdio driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
