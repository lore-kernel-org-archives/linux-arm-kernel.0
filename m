From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 23 May 2012 10:15:29 +0530
Subject: [PATCH 1/2] clk: Add support for power of two type dividers
In-Reply-To: <20120522202657.GC4386@gmail.com>
References: <1337250134-29206-1-git-send-email-rnayak@ti.com>
 <1337250134-29206-2-git-send-email-rnayak@ti.com>
 <20120522202657.GC4386@gmail.com>
Message-ID: <4FBC6B69.4090405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 May 2012 01:56 AM, Mike Turquette wrote:
> On 20120517-15:52, Rajendra Nayak wrote:
>> Quite often dividers and the value programmed in the
>> register have a relation of 'power of two', something like
>> value	div
>> 0	1
>> 1	2
>> 2	4
>> 3	8...
>>
>> Add support for such dividers as part of clk-divider.
>>
>> The clk-divider flag 'CLK_DIVIDER_POWER_OF_TWO' should be used
>> to define such clocks.
>>
>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>
> Hi Rajendra,
>
> This patch looks good to me.  I'll take it into my clk-next branch
> towards 3.6 since I'm done pulling stuff for 3.5.
>
> It's good to see CLK_DIVIDER_POWER_OF_TWO finally get used :-)

great, thanks Mike.

>
> Regards,
> Mike
