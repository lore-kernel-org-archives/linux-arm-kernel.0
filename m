From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:49:47 +0200
Subject: [PATCH 04/11] KVM: ARM/arm64: return -EFAULT if copy_from_user
 fails in set_timer_reg
In-Reply-To: <1409062410-25891-5-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-5-git-send-email-will.deacon@arm.com>
Message-ID: <20140826144947.GB6689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:23PM +0100, Will Deacon wrote:
> We currently return the number of bytes not copied if set_timer_reg
> fails, which is almost certainly not what userspace would like.
> 
> This patch returns -EFAULT instead.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
