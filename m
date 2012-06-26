From: pgaikwad@nvidia.com (Prashant G)
Date: Tue, 26 Jun 2012 08:15:09 +0530
Subject: [PATCH] ARM: tegra: Remove second instance of uart clk
In-Reply-To: <4FE8AE9C.5000109@wwwdotorg.org>
References: <1340610908-2729-1-git-send-email-pgaikwad@nvidia.com>
 <4FE8AE9C.5000109@wwwdotorg.org>
Message-ID: <4FE92235.20908@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 June 2012 12:01 AM, Stephen Warren wrote:
> On 06/25/2012 01:55 AM, Prashant Gaikwad wrote:
>> In Tegra30 clock file two clk objects were created for same UART clock.
>> Remove the duplicates and add clock aliases instead.
>>
>> Update the Tegra20 clock file to make the names consistent.
> Thanks, applied to Tegra's for-3.6/common-clk since I assume your common
> clock work will depend on this.
Thanks Stephen!!
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
