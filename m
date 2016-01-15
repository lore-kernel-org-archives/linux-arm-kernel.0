From: drjones@redhat.com (Andrew Jones)
Date: Fri, 15 Jan 2016 14:45:23 +0100
Subject: [PATCH v9 00/21] KVM: ARM64: Add guest PMU support
In-Reply-To: <1452839275-19368-1-git-send-email-zhaoshenglong@huawei.com>
References: <1452839275-19368-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160115134523.GH3915@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 02:27:34PM +0800, Shannon Zhao wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
...
> This patchset can be fetched from [1] and the relevant QEMU version for
> test can be fetched from [2].
> 
...
> [1] https://git.linaro.org/people/shannon.zhao/linux-mainline.git  KVM_ARM64_PMU_v9
> [2] https://git.linaro.org/people/shannon.zhao/qemu.git  PMU

I don't see corresponding qemu vcpu ioctl code for patch 21/21 in this
branch. Forget to push it?

Thanks,
drew
