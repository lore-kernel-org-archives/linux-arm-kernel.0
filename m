From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 26 Aug 2014 16:49:54 +0200
Subject: [PATCH 05/11] KVM: vgic: return int instead of bool when
 checking I/O ranges
In-Reply-To: <1409062410-25891-6-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
 <1409062410-25891-6-git-send-email-will.deacon@arm.com>
Message-ID: <20140826144954.GC6689@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:13:24PM +0100, Will Deacon wrote:
> vgic_ioaddr_overlap claims to return a bool, but in reality it returns
> an int. Shut sparse up by fixing the type signature.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
