From: rogerq@ti.com (Roger Quadros)
Date: Thu, 9 Jun 2016 11:20:29 +0300
Subject: [RFC v4 2/7] Revert "extcon: usb-gpio: switch to use pm wakeirq
 apis"
In-Reply-To: <5759247E.6060901@samsung.com>
References: <1465393686-16644-1-git-send-email-k.kozlowski@samsung.com>
 <1465393686-16644-3-git-send-email-k.kozlowski@samsung.com>
 <57592220.9030201@ti.com> <5759247E.6060901@samsung.com>
Message-ID: <575926CD.80608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/16 11:10, Krzysztof Kozlowski wrote:
> On 06/09/2016 10:00 AM, Roger Quadros wrote:
>> -balbi at ti
>> +balbi at kernel
>>
>> Hi,
>>
>> On 08/06/16 16:48, Krzysztof Kozlowski wrote:
>>> This reverts commit 8106e404174253639731cc30a44f5b3ab764c5b7.
>>
>> The above commit id is not present in v4.7-rc1 and this patch doesn't apply properly.
>> Can you please rebase this series on v4.7-rc1?
> 
> The commit is present in extcon tree for v4.8. The extcon patches will
> be applied (probably) to that tree so what is the point of rebasing on
> v4.7-rc1?

OK, please ignore my comment. Would be nice if you mention in the cover letter
which tree the series is based on.

> 
> Also the point of this particular patch is to show that previous change
> should be just dropped. Don't replace things to complicated devm-like
> functions just to simplify one path in the driver...
> 

--
cheers,
0roger
