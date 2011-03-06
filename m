From: ccross@android.com (Colin Cross)
Date: Sun, 6 Mar 2011 08:36:14 -0800
Subject: [PATCH 2/2] Add a default config for PAZ00
In-Reply-To: <1299421906-7366-3-git-send-email-marvin24@gmx.de>
References: <1299421906-7366-1-git-send-email-marvin24@gmx.de>
	<1299421906-7366-3-git-send-email-marvin24@gmx.de>
Message-ID: <AANLkTikvb+=ht=C+8Ze9TFT8L+WD+0C-SdkevgH3Ws3G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 6, 2011 at 6:31 AM, Marc Dietrich <marvin24@gmx.de> wrote:
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> ---
> ?arch/arm/configs/paz00_defconfig | 1209 ++++++++++++++++++++++++++++++++++++++
> ?1 files changed, 1209 insertions(+), 0 deletions(-)
> ?create mode 100644 arch/arm/configs/paz00_defconfig
>

We're trying to minimize the number of defconfigs in tree to keep
Linus happy, and all defconfigs should be minimized using "make
savedefconfig".  You can enable the paz00 board in tegra_defconfig
instead.
