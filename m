From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 12:22:50 -0700
Subject: [PATCH] clk: tegra: Add missing Tegra20 fuse clks
In-Reply-To: <1387469676-17693-1-git-send-email-pdeschrijver@nvidia.com>
References: <1387469676-17693-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <52B3478A.2030405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 09:14 AM, Peter De Schrijver wrote:

A patch description would be nice.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this is going through the clock tree, and there aren't any
dependencies between this patch and the other series touching fuses that
showed up today? (or the dependencies will be resolved by deferring
dependant patches to 3.15...)
