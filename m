From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 20 Jan 2017 11:07:00 -0300
Subject: [PATCH] clk: samsung: exynos5420: Mark CLK_ACLK432_SCALER as
 CLK_IS_CRITICAL
In-Reply-To: <48a2f141-4275-cb79-aafd-62191d747107@osg.samsung.com>
References: <CGME20170120104148epcas5p11af0e630f0881092a9b3b43e8b5b1aac@epcas5p1.samsung.com>
 <1484908891-11820-1-git-send-email-javier@osg.samsung.com>
 <551ac156-0cfa-29be-335f-d8a1f171cd8a@samsung.com>
 <0ffa0d28-1086-887c-dcfc-590b6146b03e@samsung.com>
 <48a2f141-4275-cb79-aafd-62191d747107@osg.samsung.com>
Message-ID: <6af43673-85eb-7b7d-a7f9-a7bac5070bdb@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:00 AM, Javier Martinez Canillas wrote:
> On 01/20/2017 10:55 AM, Sylwester Nawrocki wrote:

[snip]

>>
>> Oops, the $subject patch can be dropped since as Marek just pointed out
>> to me the changes introduced by that patch are already included in a patch
>> which is already in the v4.10 fixes queue:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=318fa46cc60d37fec1e87dbf03a82aca0f5ce695
>>
> 
> Yes, I just answered to Marek in the other thread saying the same.
> He did mention the patch could fix the issue but for some reason I
> didn't see the CLK_ACLK_300_GSCL in the clocks marked as critical...
>

err, I meant s/CLK_ACLK_300_GSCL/CLK_ACLK432_SCALER

I should just stop writing emails today since clearly didn't get enough coffee.
 
Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
