From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 12:44:38 -0700
Subject: [PATCH 1/4] ARM: tegra: add I2C controllers to Tegra124 DT
In-Reply-To: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
References: <1386196016-25128-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52AA1226.4000705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/2013 03:26 PM, Stephen Warren wrote:
> Tegra124 has 6 I2C controllers. The first 5 have identical configuration
> to Tegra114, but the sixth obviously has different interrupt/... IDs.

I've applied this series to Tegra's for-3.14/dt branch.
