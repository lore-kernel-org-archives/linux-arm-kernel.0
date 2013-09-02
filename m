From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Sep 2013 19:38:51 +0530
Subject: [PATCH v4 3/6] ARM: edma: Add function to manually trigger an
 EDMA channel
In-Reply-To: <1377817545-18015-4-git-send-email-joelf@ti.com>
References: <1377817545-18015-1-git-send-email-joelf@ti.com>
 <1377817545-18015-4-git-send-email-joelf@ti.com>
Message-ID: <52249BF3.6000705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/30/2013 4:35 AM, Joel Fernandes wrote:
> Manual trigger for events missed as a result of splitting a
> scatter gather list and DMA'ing it in batches. Add a helper
> function to trigger a channel incase any such events are missed.
> 
> Signed-off-by: Joel Fernandes <joelf@ti.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
