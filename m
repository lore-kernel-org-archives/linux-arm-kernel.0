From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 22 Nov 2014 20:13:58 +0100
Subject: [PATCH v14 2/7] KVM: Add generic support for dirty page logging
In-Reply-To: <1415930268-7674-3-git-send-email-m.smarduch@samsung.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <1415930268-7674-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141122191358.GL3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 05:57:43PM -0800, Mario Smarduch wrote:
> kvm_get_dirty_log() provides generic handling of dirty bitmap, currently reused
> by several architectures. Building on that we intrdoduce 
> kvm_get_dirty_log_protect() adding write protection to mark these pages dirty
> for future write access, before next KVM_GET_DIRTY_LOG ioctl call from user
> space.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
