From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 10:30:57 +0000
Subject: [PATCH 2/2] ARM: use cached memory in dma_alloc_coherent() if
	possible
In-Reply-To: <1292926802-12326-2-git-send-email-jamie@jamieiles.com>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
	<1292926802-12326-2-git-send-email-jamie@jamieiles.com>
Message-ID: <20101221103057.GK28157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 21, 2010 at 10:20:02AM +0000, Jamie Iles wrote:
> For fully coherent architectures or systems using the ARM ACP to provide
> coherency to individual device, use cached memory as the coherent
> backing rather than noncached or simply bufferable memory.

As has already been covered by Catalin, as far as we know, no one uses
the ACP yet.  Do you have a system which does?
