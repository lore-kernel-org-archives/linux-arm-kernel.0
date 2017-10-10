From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 10 Oct 2017 17:27:01 +0800
Subject: [PATCH 3/3] ACPI/IORT: Make platform devices initialization code
 SMMU agnostic
In-Reply-To: <1507038811-23382-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-4-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <59DC9265.3070709@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/3 21:53, Lorenzo Pieralisi wrote:
> The way current IORT code initializes platform devices for SMMU nodes
> is somewhat tied (mostly for naming convention) to the SMMU nodes
> themselves but it need not be in that it is completely generic and
> can easily be made so by structures renaming and code reshuffling.
>
> Rework IORT platform devices initialization code to make the functions
> and data structures SMMU agnostic.
>
> No functional changes intended.

This will be good preparation for PMCG driver support, with my comments
in patch 2/3 fixed,

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
