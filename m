From: drjones@redhat.com (Andrew Jones)
Date: Thu, 28 Jan 2016 21:54:18 +0100
Subject: [PATCH v10 19/21] KVM: ARM64: Add a new feature bit for PMUv3
In-Reply-To: <1453866709-20324-20-git-send-email-zhaoshenglong@huawei.com>
References: <1453866709-20324-1-git-send-email-zhaoshenglong@huawei.com>
 <1453866709-20324-20-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160128205418.GK16453@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 11:51:47AM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> To support guest PMUv3, use one bit of the VCPU INIT feature array.
> Initialize the PMU when initialzing the vcpu with that bit and PMU
> overflow interrupt set.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> CC: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Documentation/virtual/kvm/api.txt | 2 ++
>  arch/arm64/include/asm/kvm_host.h | 2 +-
>  arch/arm64/include/uapi/asm/kvm.h | 1 +
>  arch/arm64/kvm/reset.c            | 3 +++
>  include/kvm/arm_pmu.h             | 2 ++
>  include/uapi/linux/kvm.h          | 1 +
>  virt/kvm/arm/pmu.c                | 9 +++++++++
>  7 files changed, 19 insertions(+), 1 deletion(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
