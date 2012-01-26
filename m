From: ccross@android.com (Colin Cross)
Date: Thu, 26 Jan 2012 13:49:00 -0800
Subject: [PATCH v1 0/3] Add support for LP3
In-Reply-To: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAMbhsRQips51u_hB0-xMdFsSPCCxsehXiiSVx0D5KZxQRwTT0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 8:22 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> Introduce support for LP3 (CPU core clockgating) for Tegra20 and Tegra30.
>
> Peter De Schrijver (3):
> ?ARM: tegra: definitions for flow controller
> ?ARM: tegra: assembler code for LP3
> ?ARM: tegra: cpuidle driver for tegra
>
> ?arch/arm/mach-tegra/Makefile ? | ? ?2 +
> ?arch/arm/mach-tegra/cpuidle.c ?| ?107 ++++++++++++++++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/flowctrl.h | ? 37 ++++++++++++++
> ?arch/arm/mach-tegra/sleep.S ? ?| ? 91 ++++++++++++++++++++++++++++++++++
> ?4 files changed, 237 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-tegra/cpuidle.c
> ?create mode 100644 arch/arm/mach-tegra/flowctrl.h
> ?create mode 100644 arch/arm/mach-tegra/sleep.S

For the series,
Acked-by: Colin Cross <ccross@android.com>
