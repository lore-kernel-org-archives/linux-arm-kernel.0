From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 15:17:17 -0800
Subject: [PATCH] ARM: tegra: Harmony PCIe: Remove unnecessary include
In-Reply-To: <1326323440-23977-1-git-send-email-swarren@nvidia.com>
References: <1326323440-23977-1-git-send-email-swarren@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A80F@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren wrote at Wednesday, January 11, 2012 4:11 PM:
> This file no longer uses pinmux APIs, and hence doesn't need to include
> a pinmux header.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Oops. Ignore this; I see it was already fixed up when arm-soc's for-next
was rebuilt.

-- 
nvpublic
