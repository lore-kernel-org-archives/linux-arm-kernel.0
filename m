From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 06 Dec 2016 09:21:49 +0900
Subject: [PATCH 07/12] usb: sunxi: Uses the resource-managed extcon API
 when registering extcon notifier
In-Reply-To: <20161205163240.GA5783@uda0271908>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-8-git-send-email-cw00.choi@samsung.com>
 <20161130084503.v5klzl6silp6323s@lukather>
 <CGME20161205163324epcas4p3e5b6cf1ed5faae16d041d69ee3e5543b@epcas4p3.samsung.com>
 <20161205163240.GA5783@uda0271908>
Message-ID: <5846049D.70508@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 12? 06? 01:32, Bin Liu wrote:
> On Wed, Nov 30, 2016 at 09:45:03AM +0100, Maxime Ripard wrote:
>> On Wed, Nov 30, 2016 at 02:57:35PM +0900, Chanwoo Choi wrote:
>>> This patch just uses the resource-managed extcon API when registering
>>> the extcon notifier.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> It would be ideal if the subject was "usb: musb: sunxi: ...".
> 
> Acked-by: Bin Liu <b-liu@ti.com>
> 

Thanks for the review. I'll change the subject.

-- 
Best Regards,
Chanwoo Choi
