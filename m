From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 23 Sep 2013 18:10:30 +0400
Subject: [RFC PATCH 08/15] ata: ahci_platform: Manage SATA PHY
In-Reply-To: <20130922214859.GC27616@mtj.dyndns.org>
References: <1379595943-14622-1-git-send-email-rogerq@ti.com>
 <1379595943-14622-9-git-send-email-rogerq@ti.com>
 <523F3567.80303@cogentembedded.com> <20130922214859.GC27616@mtj.dyndns.org>
Message-ID: <52404BD6.9070101@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09/23/2013 01:48 AM, Tejun Heo wrote:

>>> @@ -37,6 +37,7 @@

>>>   #include <linux/clk.h>
>>>   #include <linux/libata.h>
>>> +#include <linux/phy/phy.h>

>> struct phy;

>> should suffice.

> Unless it's actually likely to cause inclusion loop, I think it's
> better to include the header than adding explicit declarations.

    Apparently, tastes differ here. E.g. Greg KH would have also told Roger to 
use forward declaration in such case. :-)

> Thanks.

WBR, Sergei
