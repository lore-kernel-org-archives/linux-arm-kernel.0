From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Apr 2014 15:04:48 +0900
Subject: [PATCH 03/27] ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
In-Reply-To: <4996376.GgWd9rnCP3@wuerfel>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-4-git-send-email-cw00.choi@samsung.com>
 <4996376.GgWd9rnCP3@wuerfel>
Message-ID: <534B7A80.3010509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd and Kukjin,

On 04/10/2014 06:46 PM, Arnd Bergmann wrote:
> On Thursday 10 April 2014 18:28:20 Chanwoo Choi wrote:
>> This patch add memory mapping for PMU (Power Management Unit) which is used
>> for power control of Exynos3250.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Same thing as for the SRAM here, can you work on making this a proper
> driver instead?
> 

As Chanho Park said, Sachin already submitted the DT support[1] for SYSRAM area.
[1] : http://www.spinics.net/lists/linux-samsung-soc/msg27647.html

But, this patch has not yet to merge git repository(linux-samsung.git, arm-soc.git).
So, I'll make a driver to handle PMU memory mapping after Sachin's patch is merged.

Best Regards,
Chanwoo Choi
