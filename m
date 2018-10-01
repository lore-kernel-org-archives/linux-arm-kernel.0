From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 1 Oct 2018 16:45:19 +0100
Subject: [PATCH 1/2] KVM: arm/arm64: Rename kvm_arm_config_vm to
 kvm_arm_setup_stage2
In-Reply-To: <20181001130656.36999-2-marc.zyngier@arm.com>
References: <20181001130656.36999-1-marc.zyngier@arm.com>
 <20181001130656.36999-2-marc.zyngier@arm.com>
Message-ID: <9f463e06-ae91-216c-10cd-6b3d023c59d0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2018 02:06 PM, Marc Zyngier wrote:
> VM tends to be a very overloaded term in KVM, so let's keep it
> to describe the virtual machine. For the virtual memory setup,
> let's use the "stage2" suffix.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

The intention was that the function would serve as the backend check
for the vm_type argument. That said, I am fine with the changes, FWIW:

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
