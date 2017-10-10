From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 10 Oct 2017 12:17:46 +0100
Subject: [PATCH 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
In-Reply-To: <59DC8CEC.5070005@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-3-git-send-email-lorenzo.pieralisi@arm.com>
 <59DC7ED6.50204@huawei.com> <59DC8CEC.5070005@huawei.com>
Message-ID: <20171010111746.GB28096@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 05:03:40PM +0800, Hanjun Guo wrote:
> On 2017/10/10 16:03, Hanjun Guo wrote:
> ...
> 
> >> -static __init
> >> -const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
> >> +static __init const struct iort_dev_config *iort_get_dev_cfg(
> 
> Seems patch rebase issue, this part should be in patch 3/3 :)

True, good catch, updated, thanks !

Lorenzo
