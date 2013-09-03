From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 3 Sep 2013 16:34:59 +0300
Subject: [PATCH 0/4] Introduce table driven initializations
In-Reply-To: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
References: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130903133459.GP9594@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 03:31:30PM +0200, Peter De Schrijver wrote:
> This patchset introduces a table driven initialization method for the
> audio, PMC and gate clocks. It's similar to the table we already have for
> the periph clocks.

Forgot to mention this series depends on:

[PATCH] clk: tegra: replace enum tegra114_clk by binding header
