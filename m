From: vkoul@infradead.org (Vinod Koul)
Date: Mon, 26 Nov 2012 12:19:57 +0530
Subject: [question] some question about the residue
In-Reply-To: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
References: <1353912197-16616-1-git-send-email-elen.song@atmel.com>
Message-ID: <1353912597.7077.67.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-11-26 at 14:43 +0800, Elen Song wrote:
> Hi All:
> 
> 	I got a question about the residue in struct dma_tx_state:
> 
> 	I wonder what residue means, is it the current descriptor residue or
> 
> 	the total dma buffer residue?

You read the status for descriptor, so it means this is residue for said
descriptor.


-- 
Vinod Koul
Intel Corp.
