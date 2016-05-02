From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 02 May 2016 07:55:35 +0200
Subject: Fwd: [PATCH v2 0/8] PM / devfreq: Add NoCP devfreq-event and
 support busfreq on exyno5422-odroidxu3
In-Reply-To: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
References: <1894783822.297231462168123817.JavaMail.weblogic@ep2mlwas04a>
Message-ID: <5726EBD7.30403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/2016 07:48 AM, MyungJoo Ham wrote:
> Sender : ???<cw00.choi@samsung.com> S5(??)/Change Agent/Tizen Platform Lab(S/W??)/????
> Date : 2016-04-15 15:32 (GMT+09:00)
>>
>> This patchset support the AMBA bus frequency scaling on Exynos5422-based
>> Odroid-XU3 board. But, this series only support the bus frequency scaling
>> for INT (Internal) block using VDD_INT power line.
> 
> Along with Devfreq/Passive patchset, the patchset is merged in
> devfreq for-4.7 tree.
> 
> https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/log/?h=for-4.7
> 
> @Chanwoo: If there are commits to be merged by a tree other than Linux/PM,
> please let me know. I'll send out pull-request soon.

As we discussed before, don't apply the DTS changes. The DTS are
independent so they should go through samsung/arm-soc.

Best regards,
Krzysztof
