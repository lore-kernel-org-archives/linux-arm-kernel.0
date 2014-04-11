From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 11 Apr 2014 13:44:55 +0900
Subject: [PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent
 connected with GIC
In-Reply-To: <20140411040050.GD14934@quad.lixom.net>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397124377-16969-4-git-send-email-cw00.choi@samsung.com>
 <20140411040050.GD14934@quad.lixom.net>
Message-ID: <53477347.1080603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/11/2014 01:00 PM, Olof Johansson wrote:
> On Thu, Apr 10, 2014 at 07:06:02PM +0900, Chanwoo Choi wrote:
>> This patch add interrupt-parent node to connected with GIC.
>> All interrupt-related dt nodes need default interrupt-parent node.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> There's no point in splitting these off in separate patches; fold them
> into one patch that introduces the SoC dtsi, please.

OK, I will consolidate following two patches into one patch.

[PATCH 11/27] ARM: dts: exynos3250: Add GIC dt node for Exynos3250
[PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent connected with GIC

> 
> Also, you missed your sign-off on one or two of the previous ones, but that
> won't be a problem once they're folded in. :)

I'll add my sign-off to all the patches on next posting(v2).

> 
> Finally, if the code is yours, and you're posting it, then Kyungmin should
> probably have a Reviewed-by or Acked-by tag, not a Signed-off-by. See
> Documentation/SubmittingPatches, section 12 and 13.
> 

OK, I'll change from 'Signed-off-by' to 'Acked-by'.

Thanks,

Best Regards,
Chanwoo Choi
