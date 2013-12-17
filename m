From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 17 Dec 2013 10:51:54 -0800
Subject: [PATCH v3 0/2] PSCI system off and reset for KVM ARM/ARM64
In-Reply-To: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
References: <1387280136-13622-1-git-send-email-anup.patel@linaro.org>
Message-ID: <20131217185154.GN5711@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 05:05:34PM +0530, Anup Patel wrote:
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

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

I can merge this series if Marc acks it as well.

-Christoffer
