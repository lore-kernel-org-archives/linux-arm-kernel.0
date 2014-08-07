From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Aug 2014 17:28:14 -0600
Subject: [PATCH 2/3] soc/tegra: Use of_match_machine in soc_is_tegra()
In-Reply-To: <1407452515-2390-3-git-send-email-ttynkkynen@nvidia.com>
References: <1407452515-2390-1-git-send-email-ttynkkynen@nvidia.com>
 <1407452515-2390-3-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <53E40B8E.3080100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/07/2014 05:01 PM, Tuomas Tynkkynen wrote:
> Use the new helper function, also fixing a device_node refcount leak.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this will go through some common branch in arm-soc so others 
can build on it?
