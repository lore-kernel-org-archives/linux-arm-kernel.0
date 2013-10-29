From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Oct 2013 10:31:14 +0100
Subject: [PATCH 1/2] dma: mv_xor: Remove unneeded NULL address check
In-Reply-To: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383000855-8377-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131029103114.45355c97@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Mon, 28 Oct 2013 19:54:14 -0300, Ezequiel Garcia wrote:
> This mmio address is checked at probe-time, which makes this test
> redundant. Let's just remove it.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
