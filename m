From: robherring2@gmail.com (Rob Herring)
Date: Wed, 2 Apr 2014 08:28:51 -0500
Subject: [PATCH v7 00/12] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
In-Reply-To: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
References: <1396435347-20056-1-git-send-email-anup.patel@linaro.org>
Message-ID: <CAL_Jsq+ZZbck7OnzS=ea1quUmkkToN8E==R4+DH2=VSCPMhBig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 2, 2014 at 5:42 AM, Anup Patel <anup.patel@linaro.org> wrote:
> Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
> and Coordination Interface (PSCI) v0.1.
>
> This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
> such that it does not break current KVM ARM/ARM64 ABI.
>
> The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
> KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
> PSCI v0.2 to VCPUs.

Other than my few comments, for the series:

Acked-by: Rob Herring <robh@kernel.org>

Rob
