From: pgaikwad@nvidia.com (Prashant G)
Date: Fri, 29 Jun 2012 07:36:48 +0530
Subject: [PATCH 2/6] ARM: tegra20: Separate out clk ops and clk data
In-Reply-To: <4FEC965F.4060104@wwwdotorg.org>
References: <1340879846-12900-1-git-send-email-pgaikwad@nvidia.com>
 <1340879846-12900-3-git-send-email-pgaikwad@nvidia.com>
 <4FEC965F.4060104@wwwdotorg.org>
Message-ID: <4FED0DB8.9080103@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 June 2012 11:07 PM, Stephen Warren wrote:
> On 06/28/2012 04:37 AM, Prashant Gaikwad wrote:
>> Move clock initialization data to separate file. This is
>> required for migrating to generic clock framework if static
>> initialization is used.
>>
>> TODO: Add clock suspend/resume support
> Is the suspend/resume code something that was present in the existing
> Tegra clock code? If not, I'd be tempted to just drop that TODO line
> from the patch description when applying this.
It was there for Tegra20. I am planning to add it as part of 
suspend/resume support for both Tegra30 and Tegra20.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
