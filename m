From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 05 Mar 2013 11:57:40 -0700
Subject: [PATCH 06/10] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <1362397259-5888-1-git-send-email-josephl@nvidia.com>
References: <1362397259-5888-1-git-send-email-josephl@nvidia.com>
Message-ID: <51364024.3070203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 04:40 AM, Joseph Lo wrote:
> Adding the PM configuration of PMC when the platform support suspend
> function.

I think this patch should come after the current patch 9/10. The reason
is that this patch enables system suspend using LP2 mode on the boards,
yet patches 8/10 and 9/10 are required for system suspend to operate
correctly.
