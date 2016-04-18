From: xuejiancheng@huawei.com (Jiancheng Xue)
Date: Mon, 18 Apr 2016 10:59:19 +0800
Subject: [RESEND PATCH v10 2/6] clk: hisilicon: add CRG driver for hi3519
 soc
In-Reply-To: <20160416004130.GO26353@codeaurora.org>
References: <1459411811-12390-1-git-send-email-xuejiancheng@hisilicon.com>
 <1459411811-12390-3-git-send-email-xuejiancheng@hisilicon.com>
 <57104449.8090506@huawei.com> <20160416004130.GO26353@codeaurora.org>
Message-ID: <57144D87.30401@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,
   	
On 2016/4/16 8:41, Stephen Boyd wrote:
> On 04/15, Jiancheng Xue wrote:
>> Hi,
>>
>> On 2016/3/31 16:10, Jiancheng Xue wrote:
>>> From: Jiancheng Xue <xuejiancheng@huawei.com>
>>>
>>> The CRG(Clock and Reset Generator) block provides clock
>>> and reset signals for other modules in hi3519 soc.
>>>
>>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> ---
>> I hope this patchset can be merged through arch/arm tree
>> The dts binding part has been acked by Rob Herring, and
>> the reset part has been acked by Philipp Zabel. Could you
>> help me to ack this whole clk patch? Please also let me
>> know if this patch still have issues. Thank you very much!
> 
> Can I merge it through clk tree and make a stable branch to pull
> through arm-soc? I assume another patch is coming but it's good
> to get clarity before then.
> 
Yes. It's also OK for me if this patchset can be merged into mainline
Finally. Then can I send reset controller driver, clock driver and arm-soc
patches separately?

Regards,
Jiancheng
