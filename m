From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 6 Jan 2017 11:02:20 -0300
Subject: [PATCH v5 2/5] arm64: dts: exynos: make tm2 and tm2e independent
 from each other
In-Reply-To: <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
References: <20170106134350.32428-1-andi.shyti@samsung.com>
 <CGME20170106134356epcas1p19be459900aec43b2b9ea343cdaf0a2bf@epcas1p1.samsung.com>
 <20170106134350.32428-3-andi.shyti@samsung.com>
 <20170106134929.mj7wqalp7lpkfm6b@kozik-lap>
Message-ID: <9e4fe0ee-0c33-9a5f-a954-b13d35b0113f@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/06/2017 10:49 AM, Krzysztof Kozlowski wrote:
> On Fri, Jan 06, 2017 at 10:43:47PM +0900, Andi Shyti wrote:
>> Currently tm2e dts includes tm2 but there are some differences
>> between the two boards and tm2 has some properties that tm2e
>> doesn't have.
>>
>> That's why it's important to keep the two dts files independent
>> and put all the commonalities in a tm2-common.dtsi file.
>>
>> At the current status the only two differences between the two
>> dts files (besides the board name) are ldo31 and ldo38.
>>
>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---

[snip]

 > Beside that it is starting to look good. I didn't find anything else but
> maybe Javier's eagle eye will catch something.
>

I didn't find anything else, the patch looks good to me now.
 
> 
> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
