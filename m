From: ccross@android.com (Colin Cross)
Date: Sun, 6 Mar 2011 08:34:07 -0800
Subject: [PATCH 1/2] Add initial support for the Toshiba AC100/Dynabook AZ
	netbook
In-Reply-To: <1299421906-7366-2-git-send-email-marvin24@gmx.de>
References: <1299421906-7366-1-git-send-email-marvin24@gmx.de>
	<1299421906-7366-2-git-send-email-marvin24@gmx.de>
Message-ID: <AANLkTik9v=gdtoTe_hza9onpXRfRG4_=hZuxVsgY+UVE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 6, 2011 at 6:31 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> ---
> ?arch/arm/mach-tegra/Kconfig ? ? ? ? ? ? ?| ? ?5 +
> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? | ? ?3 +
> ?arch/arm/mach-tegra/board-paz00-pinmux.c | ?157 ++++++++++++++++++++++++++++++
> ?arch/arm/mach-tegra/board-paz00.c ? ? ? ?| ?128 ++++++++++++++++++++++++
> ?arch/arm/mach-tegra/board-paz00.h ? ? ? ?| ? 22 ++++
> ?5 files changed, 315 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
> ?create mode 100644 arch/arm/mach-tegra/board-paz00.c
> ?create mode 100644 arch/arm/mach-tegra/board-paz00.h

The patch looks fine, but can you add a short patch description?
