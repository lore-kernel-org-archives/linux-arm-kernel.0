From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Aug 2013 10:44:53 -0600
Subject: [PATCH 1/1] ARM: tegra: configure power off for Dalmore
In-Reply-To: <1376894028-30060-1-git-send-email-bilhuang@nvidia.com>
References: <1376894028-30060-1-git-send-email-bilhuang@nvidia.com>
Message-ID: <52124B85.8080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19/2013 12:33 AM, Bill Huang wrote:
> Add DT property to tell the regulator to register pm_power_off to make
> "shutdown" work.

Thanks. I've forwarded this to arm-soc for hopeful inclusion in 3.12,
since it was just a little late to get into the main set of pull
requests I sent.
