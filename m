From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 17 Oct 2014 15:42:06 +0800
Subject: [PATCH v3 21/27] Powerpc/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1413530600.21650.5.camel@concordia>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>	
 <1413342435-7876-22-git-send-email-wangyijing@huawei.com>
 <1413530600.21650.5.camel@concordia>
Message-ID: <5440C84E.6050408@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/10/17 15:23, Michael Ellerman wrote:
> On Wed, 2014-10-15 at 11:07 +0800, Yijing Wang wrote:
>> Use MSI chip framework instead of arch MSI functions to configure
>> MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>> Hi Michael,
>>    I dropped the Acked-by , because this version has a
>> lot changes compared to last. So, I guess you may want to check it again.
> 
> OK thanks.
> 
> Still looks OK and boots on one of my test systems that uses MSI.

Good!

> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (for powerpc)

Thanks very much!

Thanks!
Yijing.

> 
> 
> cheers
> 
> 
> 
> .
> 


-- 
Thanks!
Yijing
