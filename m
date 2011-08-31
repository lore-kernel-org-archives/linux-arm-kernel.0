From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 31 Aug 2011 10:36:57 -0700
Subject: [PATCH 3/3] arm/dt: Tegra: Add support-bit to SDHCI nodes
In-Reply-To: <1314731837-6985-3-git-send-email-swarren@nvidia.com>
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
	<1314731837-6985-3-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A03A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Tuesday, August 30, 2011 1:17 PM:
> For Seaboard's internal eMMC, this makes the difference between a
> 5.5MB/s and 10.2MB/s transfer rate. On Harmony, there wasn't any
> measurable difference on my cheap/slow ~2MB/s card.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Grant, when applying this patch, could you possibly fix the typo in the
patch subject; s/support-bit/support-8bit/. Thanks!

-- 
nvpublic
