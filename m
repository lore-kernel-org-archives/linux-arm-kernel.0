From: agraf@suse.de (Alexander Graf)
Date: Tue, 17 Dec 2013 12:53:36 +0100
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
Message-ID: <89EFB3F4-3538-4A96-853F-880FB3A6FB64@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Am 17.12.2013 um 12:35 schrieb Anup Patel <anup.patel@linaro.org>:
> 
> The Power State and Coordination Interface (PSCI) specification defines
> SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.
> 
> This patchset adds emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions
> in KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL) using
> KVM_EXIT_SYSTEM_EVENT exit reason.
> 
> To try this patch from guest kernel, we will need PSCI-based restart and
> poweroff support in the guest kenel for both ARM and ARM64.
> 
> Rob Herring has already submitted patches for PSCI-based restart and
> poweroff in ARM kernel but these are not merged yet due unstable device
> tree bindings of kernel PSCI support. We will be having similar patches
> for PSCI-based restart and poweroff in ARM64 kernel.
> (Refer http://www.spinics.net/lists/arm-kernel/msg262217.html)
> (Refer http://www.spinics.net/lists/devicetree/msg05348.html)

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex
