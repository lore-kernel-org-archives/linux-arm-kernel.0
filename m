From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Aug 2012 16:17:53 +0200
Subject: [PATCH 4/9] ARM: pmu: remove arm_pmu_type enumeration
In-Reply-To: <1344620195-22372-5-git-send-email-will.deacon@arm.com>
References: <1344620195-22372-1-git-send-email-will.deacon@arm.com>
 <1344620195-22372-5-git-send-email-will.deacon@arm.com>
Message-ID: <CACRpkdYicRVoXb2VPDvHV4PwUfzYW7-JRSLQZh-nTswWWh7kVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2012 at 7:36 PM, Will Deacon <will.deacon@arm.com> wrote:

> From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
>
> The arm_pmu_type enumeration was initially introduced to identify
> different PMU types in the system, the usual one being that on the CPU
> (ARM_PMU_DEVICE_CPU). With the removal of the PMU reservation code and
> the introduction of devicetree bindings for the CPU PMU, the enumeration
> is no longer required.
>
> This patch removes the enumeration and updates the various CPU PMU
> platform devices so that they no longer pass an .id field referring
> to identify the PMU type.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
