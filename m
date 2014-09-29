From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Mon, 29 Sep 2014 15:01:05 +0800
Subject: [PATCH] drivers/usb/host/ehci-xilinx-of.c: Include
 "linux/of_irq.h" to avoid compiling error
In-Reply-To: <20140929015224.GB27008@kroah.com>
References: <e0dec78e-193e-43ee-bdb0-fa776a6dd044@BY2FFO11FD030.protection.gbl>
 <Pine.LNX.4.44L0.1409241141260.1580-100000@iolanthe.rowland.org>
 <20140929015224.GB27008@kroah.com>
Message-ID: <542903B1.1000601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/29/14 9:52, Greg Kroah-Hartman wrote:
> On Wed, Sep 24, 2014 at 11:41:55AM -0400, Alan Stern wrote:
>> On Mon, 22 Sep 2014, Michal Simek wrote:
>>
>>> Alan: Can you please add this patch to your queue?
>>> Greg: If Alan is not maintaining this part of kernel, is this patch in your queue?
>>>
>>> I have also not a problem to add this patch through my microblaze tree
>>> but I think it will be much better to use any USB tree.
>>
>> Greg should be able to accept a trivial patch like this one directly.
> 
> I can, if someone will resend it so I can apply it :)
> 

This patch you have already applied (applied this patch in 2014-09-24),
so I need not resend it.

Thank all of you for your work.

Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
