From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 8 Dec 2011 10:08:19 -0800
Subject: [PATCH v6 00/10] Add support for tegra30 and cardhu
In-Reply-To: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
References: <1323348254-29072-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B77A8A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Thursday, December 08, 2011 5:44 AM:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.
> 
> Patchset is on top of linux-next and
> http://www.spinics.net/lists/linux-tegra/msg03016.html.

The series,

Acked-by: Stephen Warren <swarren@nvidia.com>
Tested-by: Stephen Warren <swarren@nvidia.com>

Tested:

Two separate branches:

* next-20111208, plus the patch linked above, plus this patch series.
* My local dev branch based on next-20111206, plus all the patches I've
  posted recently, plus this patch series.

In each branch, tested the following builds:

* Non-DT build, Tegra20 only:
  - Booted Harmony, root on SD, tested audio.
* DT build, Tegra20 only:
  - Booted Harmony, root on SD, tested audio only in my dev branch.
* DT build, Tegra20 and Tegra30 support:
  - Booted Harmony, root on SD, tested audio only in my dev branch.
  - Booted Cardhu to the point of attempting to mount a root FS.
* DT build, Tegra30 support only:
  - Booted Cardhu to the point of attempting to mount a root FS

-- 
nvpublic
