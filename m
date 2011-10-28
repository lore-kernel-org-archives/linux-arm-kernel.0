From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 28 Oct 2011 10:11:48 -0700
Subject: [PATCH] arch: arm: tegra: Enable headphone detection gpio
In-Reply-To: <1319819226-19098-1-git-send-email-thutt@chromium.org>
References: <1319819226-19098-1-git-send-email-thutt@chromium.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB4E7@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Taylor Hutt wrote at Friday, October 28, 2011 10:27 AM:
> From: Yufeng Shen <miletus@chromium.org>
> 
> Enable the headphone detection gpio on tegra platform.
> 
> Signed-off-by: Yufeng Shen <miletus@chromium.org>

Aha, that explains why this seemed to have stopped working when I tried
it on Seaboard recently; I guess it never did. Harmony already does this
correctly, and that's where I must have tested the feature initially.

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
