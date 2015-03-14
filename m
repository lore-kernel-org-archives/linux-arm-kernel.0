From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 15:43:36 +0100
Subject: [PATCH 01/12] KVM: Redesign kvm_io_bus_ API to pass VCPU
 structure to the callbacks.
In-Reply-To: <1426263012-22935-2-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-2-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314144336.GI10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:01PM +0000, Andre Przywara wrote:
> From: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> 
> This is needed in e.g. ARM vGIC emulation, where the MMIO handling
> depends on the VCPU that does the access.
> 
> Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
