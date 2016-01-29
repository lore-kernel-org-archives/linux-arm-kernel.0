From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 29 Jan 2016 18:42:25 +0000
Subject: clk: scpi: Fix checking return value of
 platform_device_register_simple()
In-Reply-To: <56616311.9050208@arm.com>
References: <1449211896.14226.2.camel@ingics.com> <56616311.9050208@arm.com>
Message-ID: <56ABB291.9080802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike,

On 04/12/15 09:55, Sudeep Holla wrote:
> Hi Stephen, Mike,
>
> Can you pick up this fix for your next pull request ?
>

This seem to have got lost in the noise during holidays, can you please
pick this up ?

> On 04/12/15 06:51, Axel Lin wrote:
>> platform_device_register_simple() returns ERR_PTR on error.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>

-- 
Regards,
Sudeep
