From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Feb 2015 21:38:45 +0100
Subject: [PATCH v8 4/5] KVM: arm/arm64: remove coarse grain dist locking
 at kvm_vgic_sync_hwstate
In-Reply-To: <1421685793-3547-5-git-send-email-eric.auger@linaro.org>
References: <1421685793-3547-1-git-send-email-eric.auger@linaro.org>
 <1421685793-3547-5-git-send-email-eric.auger@linaro.org>
Message-ID: <20150223203845.GE5609@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 05:43:12PM +0100, Eric Auger wrote:
> To prepare for irqfd addition, coarse grain locking is removed at
> kvm_vgic_sync_hwstate level and finer grain locking is introduced in
> vgic_process_maintenance only.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
