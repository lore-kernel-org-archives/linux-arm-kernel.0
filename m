From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sun, 30 Oct 2016 16:49:30 +0800
Subject: [PATCH 5/5] tty: amba-pl011: Add earlycon support for SBSA UART
In-Reply-To: <20161027151849.GB32284@kroah.com>
References: <1474708465-38958-1-git-send-email-wangkefeng.wang@huawei.com>
 <1474708465-38958-6-git-send-email-wangkefeng.wang@huawei.com>
 <20160927105748.GA3847@kroah.com>
 <281fb262-d9b8-9543-e35e-5db41fcea5d1@huawei.com>
 <7edb183d-2376-0f09-a3ea-3bf78971609d@huawei.com>
 <20161027151849.GB32284@kroah.com>
Message-ID: <bdd495a9-fa54-9049-ed08-22e03a898323@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/10/27 23:18, Greg Kroah-Hartman wrote:
> On Mon, Oct 24, 2016 at 11:59:20AM +0800, Kefeng Wang wrote:
>> Hi Greg, any more comments, thanks.
> 
> Never wait, just resend if you have comments and you know you have to
> fix them up...
> 

Hi Greg, as I mentioned in previous mail, compatible "arm,sbsa-uart" need
be provided by adding a new OF_EARLYCON_DECLARE(), this is the patch's point.

And I no further update, could this patch be acceptable and be picked up?

Thanks,
Kefeng

> .
> 
