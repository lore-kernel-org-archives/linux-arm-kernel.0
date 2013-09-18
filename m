From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Sep 2013 13:38:11 -0600
Subject: [PATCH 24/26] ARM: tegra: remove custom .init_time hook
In-Reply-To: <1379526839-14798-25-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-25-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <523A0123.5060004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 11:53 AM, Sebastian Hesselbarth wrote:
> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> remove custom .init_time hooks.

Acked-by: Stephen Warren <swarren@nvidia.com>
