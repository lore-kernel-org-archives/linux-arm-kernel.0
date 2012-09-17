From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 17 Sep 2012 13:24:20 +0200
Subject: [PATCH 1/7] ARM: samsung: Remove unused fields from FIMC and CSIS
 platform data
In-Reply-To: <050d01cd94c3$f39c4210$dad4c630$%kim@samsung.com>
References: <1347878888-30001-1-git-send-email-s.nawrocki@samsung.com>
 <1347879100-30150-1-git-send-email-s.nawrocki@samsung.com>
 <050d01cd94c3$f39c4210$dad4c630$%kim@samsung.com>
Message-ID: <50570864.4090605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/17/2012 01:02 PM, Kukjin Kim wrote:
> Sylwester Nawrocki wrote:
>>
>> The MIPI-CSI2 bus data alignment is now being derived from the media
>> bus pixel code, the drivers don't use the corresponding structure
>> fields, so remove them. Also remove the s5p_csis_phy_enable callback
>> which is now used directly by s5p-csis driver.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thank you for your ack on these three first patches, I'll then ask
Mauro to push it upstream through his tree. As he usually sends
his patches out late during merge window, there should hopefully
be no merge conflicts.

Regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
