From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Feb 2014 13:56:53 -0700
Subject: [PATCH v2 0/6] ARM: firmware: improvements to Trusted Foundations
 support
In-Reply-To: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
References: <1391747706-1847-1-git-send-email-acourbot@nvidia.com>
Message-ID: <5303C915.6060500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 09:35 PM, Alexandre Courbot wrote:
> These (mostly minor) patches fix a few typos, improve points that
> were agreed upon when the Trusted Foundation series was initially
> submitted, and more importantly add support for a prepare_idle()
> firmware operation that informs the firmware a CPU is doing idle.
> Tegra's cpuidle driver is then also updated accordingly.
> 
> These patches should be the last step before device trees for NVIDIA
> SHIELD and Tegra Note 7 can be submitted.

I've applied this series to Tegra's for-3.15/tf branch (using V3 of
patch 6/6)
