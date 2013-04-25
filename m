From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 25 Apr 2013 09:16:14 +0800
Subject: [PATCH v2] ARM: Kconfig: let ARM9TDMI and ARM7TDMI invisible.
In-Reply-To: <20130424174602.GA14496@n2100.arm.linux.org.uk>
References: <51775BB3.6000607@asianux.com> <51775D88.2000406@asianux.com>
 <20130424174602.GA14496@n2100.arm.linux.org.uk>
Message-ID: <517883DE.2080603@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?25? 01:46, Russell King - ARM Linux wrote:
> On Wed, Apr 24, 2013 at 12:20:24PM +0800, Chen Gang wrote:
>> > If CONFIG_MMU is disabled, it will let ARM9TDMI and ARM7TDMI visible,
>> > but in fact, only AT91X40 need ARM7TDMI, so need not let them visible.
> I'll apply it myself this evening.  Can I add:
> 
> Tested-by: Chen Gang <gang.chen@asianux.com>
> 
> to it?
> 
> 

Ok, thanks. this patch is really provided by you (Arnd also provided the
same patch, but it seems a little later than you). And I really only
reported and tested it.

And next, I should continue to find and make another patches for ARM.

Thanks.

-- 
Chen Gang

Asianux Corporation
