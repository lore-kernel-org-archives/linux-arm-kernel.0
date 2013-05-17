From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 17:52:29 -0600
Subject: [PATCH 1/1] ARM: DT: tegra: Add gpio-leds to Tegra30 Beaver
In-Reply-To: <1368232829-25716-1-git-send-email-ebrower@nvidia.com>
References: <1368232829-25716-1-git-send-email-ebrower@nvidia.com>
Message-ID: <5196C2BD.4040709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2013 06:40 PM, Eric Brower wrote:
> Add support for general-purpose LEDs present on Beaver

I've applied this to Tegra's for-3.11/dt branch. When applying, I moved
the newly added node to maintain the node sort order.
