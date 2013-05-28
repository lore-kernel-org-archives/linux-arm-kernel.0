From: clbchenlibo.chen@huawei.com (Libo Chen)
Date: Tue, 28 May 2013 15:42:53 +0800
Subject: [PATCH] module: use a macro instead of platform_driver_register
In-Reply-To: <20130525122240.GC3746@kroah.com>
References: <51A040D2.20708@huawei.com> <20130525122240.GC3746@kroah.com>
Message-ID: <51A45FFD.8050200@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013/5/25 20:22, Greg KH wrote:
> On Sat, May 25, 2013 at 12:40:50PM +0800, Libo Chen wrote:
>>
>> I found a lot of mistakes using struct platform_driver without owner
>> so I make a macro instead of the function platform_driver_register.
>> It can set owner in it, then guys don`t care about module owner again.
>>
>> Signed-off-by: Libo Chen <libo.chen@huawei.com>
> 
> Nice job, that's the better way to fix this, I'll queue it up for 3.11.
> 

Thank Gu, Thomas, David and yours suggestions!

Regards

Libo

> thanks,
> 
> greg k-h
> 
> .
> 
