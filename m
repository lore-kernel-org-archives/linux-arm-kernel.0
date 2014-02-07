From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Fri, 07 Feb 2014 19:12:45 +0000
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <20140207182123.GE16263@obsidianresearch.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
 <52F4F23A.3030405@arm.com> <20140207182123.GE16263@obsidianresearch.com>
Message-ID: <52F5302D.5070308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/14 18:21, Jason Gunthorpe wrote:
> On Fri, Feb 07, 2014 at 02:48:26PM +0000, Sudeep Holla wrote:
>> On 06/02/14 23:42, Andrew Lunn wrote:
> 
>> Looks more like a software configuration for me unless I am missing
>> something. 
> 
> There is precedence for this, see
> Documentation/devicetree/bindings/arm/l2cc.txt
> 
> Though the feorceon name should match 'wt-override'
> 

Thanks for pointing out, may be its good to add reference to l2cc binding if its
applicable.

Do we need both wt-override and writethrough ?

>> It should not be here IMO if its pure software construct, may be you
>> can use already existing cachepolicy kernel parameter instead.
> 
> cachepolicy is already doing something very different, it would not be
> appropriate to use it for this.
> 

Yes I suspected that by a quick inspection at the code using it, but thought of
checking instead.

Regards,
Sudeep
