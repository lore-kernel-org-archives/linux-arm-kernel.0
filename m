From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 17:53:22 +0100
Subject: [PATCH v5 6/6] irqchip, gicv3-its: Use new jump label API
In-Reply-To: <1442869119-1814-7-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <1442869119-1814-7-git-send-email-rric@kernel.org>
Message-ID: <20150922175322.7d8936f5@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 22:58:39 +0200
Robert Richter <rric@kernel.org> wrote:

> From: Robert Richter <rrichter@cavium.com>
> 
> Use newly introduced jump label API.
> 
> Make this a separate patch for easier backporting to older kernels of
> the errata patch set.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
