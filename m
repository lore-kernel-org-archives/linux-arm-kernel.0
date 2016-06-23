From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 23 Jun 2016 02:37:37 +0200
Subject: [PATCH update v7 15/15] acpi,
 numa: Enable ACPI based NUMA on ARM64
In-Reply-To: <1466135582-37520-1-git-send-email-guohanjun@huawei.com>
References: <1466135582-37520-1-git-send-email-guohanjun@huawei.com>
Message-ID: <1598980.X3hO0A0n7q@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 17, 2016 11:53:02 AM Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> Add function needed for cpu to node mapping, and enable ACPI based
> NUMA for ARM64 in Kconfig
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> [david.daney at cavium.com added ACPI_NUMA default to y for ARM64]
> Signed-off-by: David Daney <david.daney@cavium.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> 
> update version:
> Address the comment from Matthias which was wrongly set srat_proc[1]
> but should be srat_proc[2].
> 
> Rafael, this patch is beased on your linux-next branch.

Applied, thanks!
