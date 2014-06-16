From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Jun 2014 11:15:30 +0100
Subject: [PATCH v14 03/10] imx-drm: Correct BGR666 and the board's dts
 that use them.
In-Reply-To: <1402913484-25910-3-git-send-email-denis@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-3-git-send-email-denis@eukrea.com>
Message-ID: <20140616101530.GY23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 12:11:17PM +0200, Denis Carikli wrote:
> The current BGR666 is not consistent with the other color mapings like BGR24.
> BGR666 should be in the same byte order than BGR24.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

As I said probably around v10 time, I already have this patch queued,
and I was going to send it to Greg before the previous merge window,
but due to the number of patches I was already carrying, it was lost
amongst the trees.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
