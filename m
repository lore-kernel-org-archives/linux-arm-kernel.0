From: cornelia.huck@de.ibm.com (Cornelia Huck)
Date: Mon, 29 Sep 2014 19:18:56 +0200
Subject: [PATCH v11 2/6] KVM: Add generic implementation of
 kvm_vm_ioctl_get_dirty_log
In-Reply-To: <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
References: <1411433690-8104-1-git-send-email-m.smarduch@samsung.com>
 <1411433690-8104-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20140929191856.63ace99d.cornelia.huck@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Sep 2014 17:54:46 -0700
Mario Smarduch <m.smarduch@samsung.com> wrote:

> Add support for generic implementation of dirty log read function. For now
> x86_64 and ARMv7 share generic dirty log read. Other architectures call
> their architecture specific functions.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

This (and the previous patch), once fitted on current kvm/next (trivial
rejects), seems to work fine on s390 and looks sane to me.

So, for the s390 parts:

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
