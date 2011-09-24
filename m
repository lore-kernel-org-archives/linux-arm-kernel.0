From: per.forlin@stericsson.com (=?ISO-8859-1?Q?Per_F=F6rlin?=)
Date: Sat, 24 Sep 2011 14:55:42 +0200
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <20110924110024.GA20044@e102144-lin.cambridge.arm.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
	<4E7DA3C0.7000208@stericsson.com>
	<20110924110024.GA20044@e102144-lin.cambridge.arm.com>
Message-ID: <4E7DD34E.3060402@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/2011 01:00 PM, Will Deacon wrote:
> On Sat, Sep 24, 2011 at 10:32:48AM +0100, Per F?rlin wrote:
>> I am trying to figure out how I can get the value of PHYS_OFFSET in assembler code (proc-v7.S).
>> I guess I could use the value calculated in arch/arm/kernel.head.S but wouldn't that make
>> this patch dependent on CONFIG_ARM_PATCH_PHYS_VIRT?
> 
> Wouldn't we just be better off passing a physical address to cpu_v7_reset
> instead?
> 
Good point! I'm fine with that.

/Per
