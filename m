From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 24 Jan 2012 21:16:33 -0800
Subject: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
In-Reply-To: <20120124090630.GR16726@n2100.arm.linux.org.uk>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
 <1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
 <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
 <20120124090630.GR16726@n2100.arm.linux.org.uk>
Message-ID: <CAN8TOE9hw8_qRd2CmkHr2eDAsbjbspD6gwQ7wpU-2skJTty-AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 1:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 24, 2012 at 12:09:04AM -0800, Brian Norris wrote:
>> However, the bug made it into the 3.3 merge window, so shouldn't this
>> bugfix be sent upstream immediately?
>
> David is the MTD maintainer, and Artem just helps out. ?I believe Artem
> is waiting for David to finish travelling before asking David (last seen
> at Hong Kong airport) to pull these fixes. ?David in turn will pass them
> onto Linus. ?Plus, Linus only started adding to -rc1 yesterday, so its a
> little early to expect this to be fixed.

Right, thanks for the reality check. I was just ensuring that this
bugfix was on the right track. I probably should have said "in
3.3-rcX", not "immediately."

Regards,
Brian
