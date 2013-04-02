From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 14:00:55 -0600
Subject: [PATCH V5 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <1364901613-25080-10-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-10-git-send-email-josephl@nvidia.com>
Message-ID: <515B38F7.5050606@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:20 AM, Joseph Lo wrote:
> Adding the PM configuration of PMC when the platform support suspend
> function.

For this patch, some more boards could be supported, but I think we'll
have to rely on other people (Lucas, Thierry) to send patches for them,
since they know the details of the board. It's fine to leave suspend
disabled on those boards until later.

Aside from the 1 other comment I made on this series, I think it's good
to go once your previous 3-long series is fixed and reposted per my
comments on it.
