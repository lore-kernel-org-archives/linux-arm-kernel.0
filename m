From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Tue, 5 Dec 2017 15:39:19 +0100
Subject: [PATCH v3 03/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_run
In-Reply-To: <20171204203538.8370-4-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-4-cdall@kernel.org>
Message-ID: <fd7436c1-2c88-5056-a822-b630f1e4ae94@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/04/2017 09:35 PM, Christoffer Dall wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_run().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com> # s390 parts

> ---
