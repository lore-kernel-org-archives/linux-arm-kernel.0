From: vijaykumar@zilogic.com (Vijay Kumar B.)
Date: Fri, 29 Jul 2016 15:14:22 +0530
Subject: Contributing to PXA2xx pinctrl Driver
In-Reply-To: <20160729091932.GB1041@n2100.armlinux.org.uk>
References: <579B1E0F.9040601@zilogic.com>
 <20160729091932.GB1041@n2100.armlinux.org.uk>
Message-ID: <579B2576.4020609@zilogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 July 2016 02:49 PM, Russell King - ARM Linux wrote:
> On Fri, Jul 29, 2016 at 02:42:47PM +0530, Vijay Kumar B. wrote:
>> Hi Everyone,
>> I am looking at the pinctrl driver for drivers/pinctrl/pxa/pxa2xx.c. The
>> driver in mainline git and pxa2xx git (rjarzmik/linux on github) seems to
>> write to allocated memory rather than to registers.
> Please explain why you think that.
>

OK, I was wrong. I misread the purpose of the allocations done in the 
init() function. Sorry for the trouble.

Regards,
Vijay
