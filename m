From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:15:47 +0200
Subject: [PATCH v4 28/56] KVM: arm/arm64: vgic-new: Add PRIORITY
 registers handlers
In-Reply-To: <1463392481-26583-29-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-29-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141547.GE6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:16AM +0100, Andre Przywara wrote:
> The priority register handlers are shared between the v2 and v3
> emulation, so their implementation goes into vgic-mmio.c, to be
> easily referenced from the v3 emulation as well later.
> There is a corner case when we change the priority of a pending
> interrupt which we don't handle at the moment.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
