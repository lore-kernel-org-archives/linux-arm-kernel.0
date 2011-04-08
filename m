From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 8 Apr 2011 21:46:19 +0200
Subject: [RFC][WAS:bcmai][PATCH V2] axi: add AXI bus driver
In-Reply-To: <1302290881.1664.7.camel@Joe-Laptop>
References: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
	<1302290881.1664.7.camel@Joe-Laptop>
Message-ID: <BANLkTi=QwBOxfxy13PxeX+LRuccV_p06zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/8 Joe Perches <joe@perches.com>:
> On Fri, 2011-04-08 at 21:45 +0200, Rafa? Mi?ecki wrote:
>> diff --git a/include/linux/axi/axi.h b/include/linux/axi/axi.h
> []
>> +#define axi_info ? ? pr_info
>> +#ifdef CONFIG_AXI_DEBUG
>> +#define axi_debug ? ?pr_debug
>> +#else
>> +#define axi_debug ? ?do { } while (0)
>> +#endif
>> +#define axi_err ? ? ? ? ? ? ?pr_err
>
> I think redefining standard functionality like
> this doesn't gain anything and loses some basic
> grep capability.

But on the other hand using:
pr_info, pr_err, BUT axi_debug
can easily lead to mistakes.

Or is this possible to re-define pr_debug locally?

-- 
Rafa?
