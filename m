From: vivek.gautam@codeaurora.org (Vivek Gautam)
Date: Fri, 5 Oct 2018 00:19:37 +0530
Subject: [PATCHv3 2/2] iommu/arm-smmu: Add SMMU clock
In-Reply-To: <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
References: <1538605693-22073-1-git-send-email-thor.thayer@linux.intel.com>
 <1538605693-22073-3-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1898b9fb-0523-4de4-741a-a52de5fdab70@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thor,


On 10/4/2018 3:58 AM, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
>
> Add a clock to the SMMU structure. In the device tree case,
> check for a clock node and enable the clock if found.
>
> This patch is dependent upon the following patches that add
> a device tree bulk clock function.
> "[V6, 1/4] clk: bulk: add of_clk_bulk_get()"
> https://patchwork.kernel.org/patch/10583133/
> "[V6, 2/4] clk: add new APIs to operation on all available
> clocks"
> https://patchwork.kernel.org/patch/10583131/
> "[V6, 3/4] clk: add managerged version of clk_bulk_get_all"
> https://patchwork.kernel.org/patch/10583139/
>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>   drivers/iommu/arm-smmu.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

The clock part is already handled by one of the patch in the
runtime pm series of arm-smmu [1]. This patch should not be needed.

[1] https://patchwork.kernel.org/patch/10581899/

[...]

Regards
Vivek
