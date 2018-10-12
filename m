From: james.morse@arm.com (James Morse)
Date: Fri, 12 Oct 2018 16:45:35 +0100
Subject: [PATCH v3 1/2] arm/arm64: KVM: rename function
 kvm_arch_dev_ioctl_check_extension()
In-Reply-To: <1539284855-4035-2-git-send-email-gengdongjiu@huawei.com>
References: <1539284855-4035-1-git-send-email-gengdongjiu@huawei.com>
 <1539284855-4035-2-git-send-email-gengdongjiu@huawei.com>
Message-ID: <5743b2ce-232f-f7e9-b5e7-3fd017575d78@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 11/10/2018 20:07, Dongjiu Geng wrote:
> Rename kvm_arch_dev_ioctl_check_extension() to
> kvm_arch_vm_ioctl_check_extension(), because it does
> not have any relationship with device.
> 
> Renaming this function can make code readable.

Lots of things in the kernel are misnamed, its not normally worth fixing them.

But it confused me, so:
Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
