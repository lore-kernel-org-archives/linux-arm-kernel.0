From: dmitriyz@google.com (Dima Zavin)
Date: Thu, 20 Jan 2011 16:42:00 -0800
Subject: [PATCH 0/7] Nexus One Support
In-Reply-To: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
References: <1295555565-21563-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <AANLkTik+HCj9dkD2s4WgwCqKWCXDbdSnKDUbyGfYfaPr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You are not the author of any of these patches. Where are the author
attributions for the team that actually wrote this code?

--Dima

On Thu, Jan 20, 2011 at 12:32 PM, Daniel Walker <dwalker@codeaurora.org> wrote:
> This series adds basic Nexus One support which includes a booting
> kernel, and functional MMC .
>
> Most people won't be able to use this yet unfortunately because
> you need a serial cable to get any output. However, it's a start.
>
> Brian Swetland (1):
> ?[ARM] msm: qsd8k memory base is at 0x20000000
>
> Daniel Walker (6):
> ?msm: qsd8x50: add uart platform data
> ?msm: qsd8x50: add acpuclock code
> ?msm: mahimahi: add mahimahi board file
> ?msm: mahimahi: add in mmc support code
> ?msm: mahimahi: add gpio pin muxing code
> ?msm: mahimahi: initialize mmc at start up
>
> ?arch/arm/mach-msm/Kconfig ? ? ? ? ? ? ?| ? ?8 +-
> ?arch/arm/mach-msm/Makefile ? ? ? ? ? ? | ? ?5 +-
> ?arch/arm/mach-msm/Makefile.boot ? ? ? ?| ? ?5 +
> ?arch/arm/mach-msm/acpuclock-qsd8x50.c ?| ?457 ++++++++++++++++++++++++++++++++
> ?arch/arm/mach-msm/board-mahimahi-mmc.c | ?238 +++++++++++++++++
> ?arch/arm/mach-msm/board-mahimahi.c ? ? | ? 52 +++-
> ?arch/arm/mach-msm/board-mahimahi.h ? ? | ?147 ++++++++++
> ?arch/arm/mach-msm/devices-qsd8x50.c ? ?| ? 42 +++
> ?arch/arm/mach-msm/include/mach/board.h | ? ?1 +
> ?9 files changed, 942 insertions(+), 13 deletions(-)
> ?create mode 100644 arch/arm/mach-msm/acpuclock-qsd8x50.c
> ?create mode 100644 arch/arm/mach-msm/board-mahimahi-mmc.c
> ?create mode 100644 arch/arm/mach-msm/board-mahimahi.h
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at ?http://www.tux.org/lkml/
>
