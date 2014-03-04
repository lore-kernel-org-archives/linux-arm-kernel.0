From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 4 Mar 2014 11:07:52 +0200
Subject: [PATCH 1/5] drivers: bus: omap_l3: Convert to use devm_kzalloc
In-Reply-To: <1393923710-10377-2-git-send-email-peter.ujfalusi@ti.com>
References: <1393923710-10377-1-git-send-email-peter.ujfalusi@ti.com>
 <1393923710-10377-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <531597E8.50509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:01 AM, Peter Ujfalusi wrote:
> We can remove the kfree() calls from probe and remove.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti>

Where did the ".com" went from Santosh's email address??
I'll resend it in a minute with a fixed commit message.

-- 
P?ter
