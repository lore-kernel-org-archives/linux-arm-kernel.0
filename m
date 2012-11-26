From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Nov 2012 14:55:40 -0700
Subject: [PATCH] ARM: use clockevents_config_and_register() where possible
In-Reply-To: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
References: <1353936857-15313-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <50B3E55C.4040008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2012 06:34 AM, Shawn Guo wrote:
> The clockevent core is able to figure out the best mult and shift,
> calculate min_delta_ns and max_delta_ns, with the necessary info passed
> into clockevents_config_and_register().  Use this combined configure
> and register function where possible to make the codes less error prone
> and gain some positive diff stat.

For the Tegra portions,
Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
