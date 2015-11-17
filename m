From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 17 Nov 2015 20:34:32 +0800
Subject: [PATCH v3 33/62] arm/uart: Create generic uart initialization
 function
In-Reply-To: <564B143C.1070901@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-34-git-send-email-shannon.zhao@linaro.org>
 <564B143C.1070901@citrix.com>
Message-ID: <564B1ED8.2020202@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/17 19:49, Julien Grall wrote:
> Hi Shannon,
> 
> On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
>> From: Parth Dixit <parth.dixit@linaro.org>
>>
>> Rename dt-uart.c to arm-uart.c and create new generic uart init function.
>> Move dt_uart_init to arm_uart_init.
> 
> It's very hard to review a patch to move existing code and add new one.
> Please split it in 2.
> 
Ok, thanks.

-- 
Shannon
