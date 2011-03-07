From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 7 Mar 2011 11:06:39 +0100
Subject: [PATCH 0/3] ARM: Add Scorpion/ScorpionMP support to perf and
	Oprofile
In-Reply-To: <1299276551-11978-1-git-send-email-sheetals@codeaurora.org>
References: <1299276551-11978-1-git-send-email-sheetals@codeaurora.org>
Message-ID: <AANLkTinmRZ4H_UCDokx=WgPYxCSvP1is7uwRZ9KtC4rZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 4, 2011 at 11:09 PM, Sheetal Sahasrabudhe
<sheetals@codeaurora.org> wrote:
> This patchset contains the following features:
> It adds support for Qualcomm Scorpion and ScorpionMP processors to perfevents
> and Oprofile.
> It adds PMU support for Scorpion and ScorpionMP.
> It also updates PMU IRQ identifiers for various Scorpion and ScorpionMP targets.
>
> Sheetal Sahasrabudhe (3):
> ?msm: Add support for Scorpion and ScorpionMP PMU
> ?[ARM] perfevents: Add support for Scorpion performance monitors
> ?[ARM] Oprofile: Add Qualcomm Scorpion and ScorpionMP CPU type
>
> ?arch/arm/include/asm/perf_event.h ? ? ? ? ?| ? ?2 +
> ?arch/arm/kernel/perf_event.c ? ? ? ? ? ? ? | ? 11 +
> ?arch/arm/kernel/perf_event_qc.c ? ? ? ? ? ?| ?677 ++++++++++++++++++++++++++++
> ?arch/arm/mach-msm/Makefile ? ? ? ? ? ? ? ? | ? ?2 +
> ?arch/arm/mach-msm/include/mach/irqs-7x30.h | ? ?2 +-
> ?arch/arm/mach-msm/include/mach/irqs-8960.h | ? ?2 +-
> ?arch/arm/mach-msm/include/mach/irqs-8x50.h | ? ?2 +-
> ?arch/arm/mach-msm/include/mach/irqs-8x60.h | ? ?2 +-
> ?arch/arm/mach-msm/pmu.c ? ? ? ? ? ? ? ? ? ?| ? 36 ++
> ?arch/arm/oprofile/common.c ? ? ? ? ? ? ? ? | ? ?4 +
> ?10 files changed, 736 insertions(+), 4 deletions(-)
> ?create mode 100644 arch/arm/kernel/perf_event_qc.c
> ?create mode 100644 arch/arm/mach-msm/pmu.c
>

I cannot test on the actual HW so here is the review ack:
Reviewed-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

> --
> 1.7.4.1
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum
>
>
