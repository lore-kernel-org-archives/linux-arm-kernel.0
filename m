From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 12 May 2016 10:56:57 +0100
Subject: [PATCH v3 27/55] KVM: arm/arm64: vgic-new: Add PRIORITY registers
 handlers
In-Reply-To: <57344889.1050802@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-28-git-send-email-andre.przywara@arm.com>
 <57344889.1050802@arm.com>
Message-ID: <CAFEAcA95nt_4wueOTzergNfupg4zGMTj_EQgCLrRunpg6GUbPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2016 at 10:10, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This is wrong. We should only write the number of bits of priority we
> actually emulate. And given that we use a common framework for v2 and
> v3, this should probably be 5 bits (32 priorities should be enough for
> everybody).

FWIW QEMU's GICv2 and GICv3 emulations both implement the full
8 bits of priority.

thanks
-- PMM
