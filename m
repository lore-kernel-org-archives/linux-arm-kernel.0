From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Dec 2015 19:04:46 +0100
Subject: [PATCH] KVM: arm/arm64: vgic: make vgic_io_ops static
In-Reply-To: <1447329554-1500-1-git-send-email-jszhang@marvell.com>
References: <1447329554-1500-1-git-send-email-jszhang@marvell.com>
Message-ID: <20151202180446.GP18376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 07:59:14PM +0800, Jisheng Zhang wrote:
> vgic_io_ops is only referenced within vgic.c, so it can be declared
> static.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Applied to queue,
-Christoffer
