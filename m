From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 May 2014 21:51:29 +0200
Subject: [PATCH v6 1/4] add ARMv7 HYP API to flush VM TLBs without
 address param
In-Reply-To: <1400178451-4984-2-git-send-email-m.smarduch@samsung.com>
References: <1400178451-4984-1-git-send-email-m.smarduch@samsung.com>
 <1400178451-4984-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140527195129.GA16428@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 11:27:28AM -0700, Mario Smarduch wrote:
> Patch adds HYP interface for global VM TLB invalidation without address
> parameter. Added ARM version of kvm_flush_remote_tlbs(), made generic one weak.

nit: made the generic implementation a weak symbol.
