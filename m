From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 15:36:08 +0200
Subject: [PATCH v11 2/6] KVM: Add generic implementation of
 kvm_vm_ioctl_get_dirty_log
In-Reply-To: <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140929133608.GI3095@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 05:54:46PM -0700, Mario Smarduch wrote:
> Add support for generic implementation of dirty log read function. For now
> x86_64 and ARMv7 share generic dirty log read. Other architectures call
> their architecture specific functions.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---

This looks reasonable to me,

Other arch kvm-maintainers: will you give this a look and a spin for
your ok?

Thanks,
-Christoffer
