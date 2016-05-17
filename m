From: a0393675@ti.com (Keerthy)
Date: Tue, 17 May 2016 08:52:06 +0530
Subject: [PATCH 2/8] Documentation: regulator: tps65218: Update examples
In-Reply-To: <20160516144847.GA26659@rob-hp-laptop>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-3-git-send-email-j-keerthy@ti.com>
 <20160516144847.GA26659@rob-hp-laptop>
Message-ID: <573A8E5E.2080809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 16 May 2016 08:18 PM, Rob Herring wrote:
> On Wed, May 11, 2016 at 11:18:05AM +0530, Keerthy wrote:
>> This updates the device tree according to the preferred way of parsing
>> the nodes using the regulator framework.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   .../devicetree/bindings/regulator/tps65218.txt     | 87 ++++++++++++++++++----
>>   1 file changed, 71 insertions(+), 16 deletions(-)
>
> It wasn't exactly clear that the compatible string "added" here is
> already used, so it looked like you were breaking compatibility at
> first. Otherwise,
>
> Acked-by: Rob Herring <robh@kernel.org>

Thanks Rob.

>
