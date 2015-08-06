From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Thu, 06 Aug 2015 16:01:45 +0530
Subject: [PATCH v7 12/13] clk: qcom: gdsc: Add GDSCs in apq8084 MMCC
In-Reply-To: <55BB8C40.507@mm-sol.com>
References: <1438076046-4706-1-git-send-email-rnayak@codeaurora.org>
 <1438076046-4706-13-git-send-email-rnayak@codeaurora.org>
 <55BB8C40.507@mm-sol.com>
Message-ID: <55C33791.6010506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/31/2015 08:24 PM, Stanimir Varbanov wrote:
>
> <snip>
>
>>
>> +static struct gdsc venus0_gdsc = {
>> +	.gdscr = 0x1024,
>> +	.pd = {
>> +		.name = "venus0",
>> +	},
>> +	.pwrsts = PWRSTS_OFF_ON,
>> +	.con_ids = { NULL },
>> +};
>> +
>
> Rajendra, according to downstream kernel apq8084 has second instance of
> gdsc i.e. venus1_gdsc, is that correct?

Stan, it does seem like there are 3 instances of venus gdscs', venus0,
venus0_core0 and venus0_core1. I will add the missing ones when I
repost,thanks.
