From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 22 Jan 2014 13:47:07 -0700
Subject: [PATCH 0/5] ARM: firmware: improvements to Trusted Foundations
 support
In-Reply-To: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
References: <1390299016-14105-1-git-send-email-acourbot@nvidia.com>
Message-ID: <52E02E4B.5060206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 03:10 AM, Alexandre Courbot wrote:
> These (mostly minor) patches fix a few typos, improve points that
> were agreed upon when the Trusted Foundation series was initially
> submitted, and more importantly add support for the do_idle() firmware
> operation that is needed for cpuidle to be supported. Tegra's cpuidle
> driver is also updated accordingly.
> 
> These patches should be the last step before the device trees for NVIDIA
> SHIELD and Tegra Note 7 can be submitted.

Russell, once these patches are reviewed, should Alex submit them to the
ARM patch tracker, or will you Ack them so they can go through the Tegra
tree? Either way I can put them in a separate branch based on 3.14-rc1
in order to easily resolve any conflicts.
