From: julien.grall@arm.com (Julien Grall)
Date: Tue, 25 Apr 2017 13:51:22 +0100
Subject: [PATCH 1/2] xen/arm, arm64: fix xen_dma_ops after 815dd18
 "Consolidate get_dma_ops..."
In-Reply-To: <alpine.DEB.2.10.1704241214100.16723@sstabellini-ThinkPad-X260>
References: <1492117462-19886-1-git-send-email-sstabellini@kernel.org>
 <20170418142126.GE27592@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.10.1704191023120.31486@sstabellini-ThinkPad-X260>
 <alpine.DEB.2.10.1704241214100.16723@sstabellini-ThinkPad-X260>
Message-ID: <f0667d8c-1c17-8d5f-a5d7-1e0d014e86ec@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 24/04/17 20:16, Stefano Stabellini wrote:
> Given the outstanding regression we need to fix as soon as possible,
> I'll queue these patches on the xentip tree for 4.12.

It looks like there is another rc for 4.11. I am wondering whether you 
could try to send a pull request to Linus so it can be fixed in 4.11?

Cheers,

-- 
Julien Grall
