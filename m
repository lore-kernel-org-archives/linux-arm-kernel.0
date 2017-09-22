From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 22 Sep 2017 12:25:08 +0100
Subject: [RFC PATCH v2 1/4] ACPICA: Add SMMUv3 device ID mapping index
 support
In-Reply-To: <1505999838-52530-2-git-send-email-guohanjun@huawei.com>
References: <1505999838-52530-1-git-send-email-guohanjun@huawei.com>
 <1505999838-52530-2-git-send-email-guohanjun@huawei.com>
Message-ID: <20170922112508.GB3475@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 09:17:15PM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> SMMUv3 device ID mapping index is used for SMMUv3
> MSIs, update the IORT to support that.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  include/acpi/actbl2.h | 1 +
>  1 file changed, 1 insertion(+)

Have you sent the related git pull ACPICA upstream ?

Lorenzo

> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
> index 686b6f8..d90277e 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -810,6 +810,7 @@ struct acpi_iort_smmu_v3 {
>  	u8 pxm;
>  	u8 reserved1;
>  	u16 reserved2;
> +	u32 id_mapping_index;
>  };
>  
>  /* Values for Model field above */
> -- 
> 1.7.12.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
