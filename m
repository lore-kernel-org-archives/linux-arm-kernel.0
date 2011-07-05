From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 05 Jul 2011 11:42:15 -0700
Subject: [PATCH] ARM: omap4: rename gpmc clock to gpmc_ick
In-Reply-To: <87oc18r2y3.fsf@ti.com>
References: <1309868377-22379-1-git-send-email-j.weitzel@phytec.de>	<4E1340AA.2020007@ti.com>
	<87oc18r2y3.fsf@ti.com>
Message-ID: <4E135B07.80801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/5/2011 11:35 AM, Kevin Hilman wrote:
> Santosh Shilimkar<santosh.shilimkar@ti.com>  writes:
>
>> + Benoit
>>
>> On 7/5/2011 5:19 AM, Jan Weitzel wrote:
>>> The gpmc clock on omap44xx is called gpmc_ick not gpmc_ck in
>>> clock44xx_data.c
>>>
>>> Signed-off-by: Jan Weitzel<j.weitzel@phytec.de>
>> This happened after renaming the clock-nodes some time back.
>> Looks good to me as a fix though in long run GPMC should be
>> moved to hwmod to avoid such naming issues
>
> In fact, Benoit has already done it[1] as part of his last series:
> [PATCH v2 0/4] OMAP4: Add modulemode support to hwmod framework (part 2)
>
Ohh yes. I remember now about the discussion with him on the GPMC patch
which he did as a followup patch to mine similar clock framework
patch [1]

Thanks for the link.

Regards
Santosh
[1] https://patchwork.kernel.org/patch/937422/
