From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 Jun 2012 11:37:35 -0600
Subject: [PATCH 2/6] ARM: tegra20: Separate out clk ops and clk data
In-Reply-To: <1340879846-12900-3-git-send-email-pgaikwad@nvidia.com>
References: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
 <1340879846-12900-3-git-send-email-pgaikwad@nvidia.com>
Message-ID: <4FEC965F.4060104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2012 04:37 AM, Prashant Gaikwad wrote:
> Move clock initialization data to separate file. This is
> required for migrating to generic clock framework if static
> initialization is used.
> 
> TODO: Add clock suspend/resume support

Is the suspend/resume code something that was present in the existing
Tegra clock code? If not, I'd be tempted to just drop that TODO line
from the patch description when applying this.
