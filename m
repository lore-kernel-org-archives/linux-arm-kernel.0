From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 23 May 2014 14:08:17 +0900
Subject: [PATCH RFC v2 0/7] Devfreq support for Exynos5250/5420
In-Reply-To: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
References: <1400779322-4410-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <537ED7C1.5030601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/23/2014 02:21 AM, Abhilash Kesavan wrote:
> This patchset adds devfreq support on Exynos5250 and Exynos5420.
> The patches add the missing INT clock support for exynos5250 and
> also add a new 5420 driver. We also have patches which add the
> PPMU node and fix a typo in the exynos5250 driver.
> 
> Changes since RFC v1:
> 	- Exynos5420 support has been added to the existent Exynos5250
> 	  driver itself.
> 	- Rebased on Chanwoo Choi's devfreq consolidation patchset.
> 	- Removed unused clocks from the clock list
> 	- Used the PPMU nodes with different compatible strings to
> 	  differentiate between exynos5250 and exynos5420.
> 
> The patches have been tested on Exynos5250 based Snow board and Exynos5420
> based Peach-Pit boards. They have been prepared on linux-next(20140521) with
> the devfreq for-next branch merged. Also applied is the "devfreq resource
> management" series from Chanwoo Choi[1].
> [1] https://lkml.org/lkml/2014/4/25/826

I sent v2 patchset as following after fixed minor issue:
[PATCHv2 0/5] devfreq: Support resource management functions and code clean
- https://lkml.org/lkml/2014/5/9/74

Best Regards,
Chanwoo Choi
