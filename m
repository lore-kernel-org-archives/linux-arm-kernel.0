From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 3 Apr 2014 09:00:10 +0800
Subject: [PATCH 1/2] ARM: hisi: enable L2 driver
In-Reply-To: <20140402170034.GK7528@n2100.arm.linux.org.uk>
References: <1396445663-1357-1-git-send-email-haojian.zhuang@linaro.org>
 <20140402170034.GK7528@n2100.arm.linux.org.uk>
Message-ID: <CAD6h2NTivn_Cs6fspaNxFRe2nyH-70q8fwnvAmugfJQJ08+0dA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 April 2014 01:00, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Wed, Apr 02, 2014 at 09:34:22PM +0800, Haojian Zhuang wrote:
>> +static void __init hi3xxx_init(void)
>> +{
>> +     l2x0_of_init(0, ~0UL);
>
>         l2x0_of_init(0, ~0);
>
> please, no need for a UL suffix on it.
>
Got it.

Thanks
Haojian
