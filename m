From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 13:56:26 -0600
Subject: [PATCH] clk: tegra: PLLE spread spectrum control
In-Reply-To: <1380209654-25458-1-git-send-email-pdeschrijver@nvidia.com>
References: <1380209654-25458-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <524B28EA.40702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/2013 09:34 AM, Peter De Schrijver wrote:
> Add spread spectrum control for PLLE in Tegra114.

It would be useful to have some description of the end-user-visible
benefit of this change; why is it useful?

Tested-by: Stephen Warren <swarren@nvidia.com>
(on Beaver and Harmony, a PCIe Ethernet NIC passes traffic just fine).
