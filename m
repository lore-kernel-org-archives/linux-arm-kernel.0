From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Aug 2016 10:23:00 +0100
Subject: [PATCH] arm64: KVM: Enable support for Cortex-A72
In-Reply-To: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
References: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160824102300.2b7f34e3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Aug 2016 15:21:37 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

Hi Shannon,

> In order to allow KVM to run on Cortex-A72 physical cpus, enable KVM
> support for Cortex-A72.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Why do we need any of this?

Since bca556ac468a ("arm64/kvm: Add generic v8 KVM target"), we support
any CPU that can run KVM without any change to the kernel, and I've
been running KVM on A72 for quite some time now (Juno r2, Armada 7040).

Am I missing something obvious?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
