From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Oct 2012 16:38:53 -0600
Subject: [PATCH 4/7] ARM: tegra30: common: enable csite clock
In-Reply-To: <1349691981-31038-5-git-send-email-josephl@nvidia.com>
References: <1349691981-31038-1-git-send-email-josephl@nvidia.com>
 <1349691981-31038-5-git-send-email-josephl@nvidia.com>
Message-ID: <5074A77D.9080500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2012 04:26 AM, Joseph Lo wrote:
> Enable csite (debug and trace controller) clock at init to prevent it
> be disabled. And this also the necessary clock for CPU be brought up or
> resumed from a power-gate low power state (e.g., LP2).

Does it make sense to enable this clock only when entering LP2? Or do we
really need to keep it on 100% of the time?
