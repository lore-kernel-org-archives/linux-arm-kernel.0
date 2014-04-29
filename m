From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 29 Apr 2014 12:43:20 -0700
Subject: [PATCH v11 02/12] ARM/ARM64: KVM: Add common header for PSCI
 related defines
In-Reply-To: <1398750865-10892-3-git-send-email-anup.patel@linaro.org>
References: <1398750865-10892-1-git-send-email-anup.patel@linaro.org>
 <1398750865-10892-3-git-send-email-anup.patel@linaro.org>
Message-ID: <20140429194320.GB3003@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 11:24:15AM +0530, Anup Patel wrote:
> We need a common place to share PSCI related defines among ARM kernel,
> ARM64 kernel, KVM ARM/ARM64 PSCI emulation, and user space.
> 
> We introduce uapi/linux/psci.h for this purpose. This newly added
> header will be first used by KVM ARM/ARM64 in-kernel PSCI emulation
> and user space (i.e. QEMU or KVMTOOL).
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> ---

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
