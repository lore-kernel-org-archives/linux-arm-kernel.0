From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Mar 2014 13:37:15 -0700
Subject: [PATCH] ARM: tegra: use 2 address cells for Tegra124 DT
In-Reply-To: <1393953357-32673-1-git-send-email-swarren@wwwdotorg.org>
References: <1393953357-32673-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <53178AFB.5010000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 10:15 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra124 can support 4GB of RAM. With that much RAM (plus some memory-
> mapped IO peripherals), more than 32-bits of physical address space is
> required. Hence, convert all Tegra124 DTs to use 2 DT cells for address
> space.
> 
> (I think this was suggested by Olof Johansson, but I'm not 100% sure)

I've applied this to Tegra's for-3.15/dt branch.
