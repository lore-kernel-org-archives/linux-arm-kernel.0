From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 10 Oct 2017 17:03:40 +0800
Subject: [PATCH 2/3] ACPI/IORT: Improve functions return type/storage
 class specifier indentation
In-Reply-To: <59DC7ED6.50204@huawei.com>
References: <1507038811-23382-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1507038811-23382-3-git-send-email-lorenzo.pieralisi@arm.com>
 <59DC7ED6.50204@huawei.com>
Message-ID: <59DC8CEC.5070005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/10 16:03, Hanjun Guo wrote:
...

>> -static __init
>> -const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
>> +static __init const struct iort_dev_config *iort_get_dev_cfg(

Seems patch rebase issue, this part should be in patch 3/3 :)

Thanks
Hanjun
