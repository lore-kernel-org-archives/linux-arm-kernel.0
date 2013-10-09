From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Oct 2013 17:21:14 -0600
Subject: [PATCH 2/7] ARM: tegra: add flow controller to support suspend
 for Tegra124
In-Reply-To: <1381310411-11391-3-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-3-git-send-email-josephl@nvidia.com>
Message-ID: <5255E4EA.8060002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2013 03:20 AM, Joseph Lo wrote:
> Enable the configuration of flow controller to support the last CPU
> (CPU0) suspend function with cluster power down.

I'd be tempted to squash together patches 2 and 3 since they're
basically doing the same kind of thing and are pretty trivial.
