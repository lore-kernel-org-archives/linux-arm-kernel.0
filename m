From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 25 Apr 2013 01:59:59 +0800
Subject: [PATCH v2] ARM: Kconfig: let ARM9TDMI and ARM7TDMI invisible.
In-Reply-To: <20130424174602.GA14496@n2100.arm.linux.org.uk>
References: <51775BB3.6000607@asianux.com> <51775D88.2000406@asianux.com>
 <20130424174602.GA14496@n2100.arm.linux.org.uk>
Message-ID: <8EB7C52E-5044-4B8A-99F2-BCFF9DFDBD2E@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Apr 25, 2013, at 1:46 AM, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Apr 24, 2013 at 12:20:24PM +0800, Chen Gang wrote:
>> If CONFIG_MMU is disabled, it will let ARM9TDMI and ARM7TDMI visible,
>> but in fact, only AT91X40 need ARM7TDMI, so need not let them visible.
> 
> I'll apply it myself this evening.  Can I add:
> 
> Tested-by: Chen Gang <gang.chen@asianux.com>
you add it mine too

Tested-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> 
> to it?
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
