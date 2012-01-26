From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 26 Jan 2012 10:33:40 -0800
Subject: [PATCH v1 0/3] Add support for LP3
In-Reply-To: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
References: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB823CD@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, January 26, 2012 9:22 AM:
> Introduce support for LP3 (CPU core clockgating) for Tegra20 and Tegra30.

The series,

Acked-by: Stephen Warren <swarren@nvidia.com>

(although I'm not very familiar with cpuidle, so a review from e.g.
Colin would be great too)

Tested-by: Stephen Warren <swarren@nvidia.com>

(On Harmony, observed /sys/devices/system/cpu/cpu*/cpuidle/state0/usage
incrementing over time. Tested audio playback as well)

-- 
nvpublic
