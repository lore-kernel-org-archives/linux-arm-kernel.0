From: ccross@android.com (Colin Cross)
Date: Wed, 23 Feb 2011 11:08:50 -0800
Subject: [PATCH 4/5] ARM: Tegra: Create defines for GPIO names
In-Reply-To: <1298487532-5000-5-git-send-email-swarren@nvidia.com>
References: <1298487532-5000-1-git-send-email-swarren@nvidia.com>
	<1298487532-5000-5-git-send-email-swarren@nvidia.com>
Message-ID: <AANLkTinPssv8Wpy0Qe5GAHqN=9dicSLZ8sUmq+JeW2_q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 10:58 AM, Stephen Warren <swarren@nvidia.com> wrote:
> This ensures they're kept in sync between platform_data definitions and
> the GPIO table initialization.
>
Can you name these for what they are used for (if they have a single use)?
i.e. TEGRA_GPIO_EMMC_CD instead of TEGRA_GPIO_SD2_CD
