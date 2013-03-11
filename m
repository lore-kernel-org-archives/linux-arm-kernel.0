From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Mar 2013 11:05:50 +0530
Subject: [PATCH 3/8] memory: emif: handle overflow for timing for LP mode
In-Reply-To: <1362978365-5593-4-git-send-email-lokeshvutla@ti.com>
References: <1362978365-5593-1-git-send-email-lokeshvutla@ti.com>
 <1362978365-5593-4-git-send-email-lokeshvutla@ti.com>
Message-ID: <513D6D36.7060909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 March 2013 10:36 AM, Lokesh Vutla wrote:
> From: Nishanth Menon <nm@ti.com>
> 
> In case the custom timings provide values which overflow
> the maximum possible field value, warn and use maximum
> permissible value.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
