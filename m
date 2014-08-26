From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:50:01 +0200
Subject: [PATCH 06/11] KVM: vgic: declare probe function pointer as const
In-Reply-To: <1409062410-25891-7-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-7-git-send-email-will.deacon@arm.com>
Message-ID: <20140826145001.GD6689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:25PM +0100, Will Deacon wrote:
> We extract the vgic probe function from the of_device_id data pointer,
> which is const. Kill the sparse warning by ensuring that the local
> function pointer is also marked as const.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
