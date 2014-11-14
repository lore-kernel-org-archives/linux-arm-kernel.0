From: cornelia.huck@de.ibm.com (Cornelia Huck)
Date: Fri, 14 Nov 2014 09:06:59 +0100
Subject: [PATCH v14 0/7] KVM/arm/x86: dirty page logging for ARMv7
 (3.17.0-rc1)
In-Reply-To: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141114090659.4ae4f609.cornelia.huck@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Nov 2014 17:57:41 -0800
Mario Smarduch <m.smarduch@samsung.com> wrote:

> Patch series adds support for ARMv7 and generic dirty page logging support. 
> As we try to move towards generic dirty page logging additional logic is moved 
> to generic code. Initially x86, armv7 KVM_GET_DIRTY_LOG reuses generic 
> code, shortly followed by armv8 patches.

FWIW: s390 (with qemu/master) seems to work as before.
