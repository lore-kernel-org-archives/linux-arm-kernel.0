From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 02 May 2016 08:24:16 +0200
Subject: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and
 support busfreq on exyno5422-odroidxu3
In-Reply-To: <5726EE55.7050204@samsung.com>
References: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
 <5726EBD7.30403@samsung.com> <5726EE55.7050204@samsung.com>
Message-ID: <5726F290.8050808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 08:06 AM, Krzysztof Kozlowski wrote:
> On 05/02/2016 07:55 AM, Krzysztof Kozlowski wrote:
>> On 05/02/2016 07:48 AM, MyungJoo Ham wrote:
>>> Sender : ???<cw00.choi@samsung.com> S5(??)/Change Agent/Tizen Platform Lab(S/W??)/????
>>> Date : 2016-04-15 15:32 (GMT+09:00)
>>>>
>>>> This patchset support the AMBA bus frequency scaling on Exynos5422-based
>>>> Odroid-XU3 board. But, this series only support the bus frequency scaling
>>>> for INT (Internal) block using VDD_INT power line.
>>>
>>> Along with Devfreq/Passive patchset, the patchset is merged in
>>> devfreq for-4.7 tree.
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-4.7
>>>
>>> @Chanwoo: If there are commits to be merged by a tree other than Linux/PM,
>>> please let me know. I'll send out pull-request soon.

... and now I noticed that you also applied clock patches. Please don't.
They are for some time in clk tree. Sylwester prepared a tag for that,
if you need one.

Best regards,
Krzysztof
