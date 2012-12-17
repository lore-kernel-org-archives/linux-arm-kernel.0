From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 17 Dec 2012 14:44:19 -0700
Subject: [PATCH 2/4] ARM: tegra: add connection name for uart clock table
In-Reply-To: <1355746101-15291-3-git-send-email-ldewangan@nvidia.com>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
 <1355746101-15291-3-git-send-email-ldewangan@nvidia.com>
Message-ID: <50CF9233.3010506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2012 05:08 AM, Laxman Dewangan wrote:
> Add connection name "uart-clk" for the uart clock information.

Does the UART receive more than one clock, so that it actually cares
what the clock connection name is? If not, can we just drop this patch?
