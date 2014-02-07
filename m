From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Feb 2014 11:21:23 -0700
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <52F4F23A.3030405@arm.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
 <52F4F23A.3030405@arm.com>
Message-ID: <20140207182123.GE16263@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 02:48:26PM +0000, Sudeep Holla wrote:
> On 06/02/14 23:42, Andrew Lunn wrote:

> Looks more like a software configuration for me unless I am missing
> something. 

There is precedence for this, see
Documentation/devicetree/bindings/arm/l2cc.txt

Though the feorceon name should match 'wt-override'

> It should not be here IMO if its pure software construct, may be you
> can use already existing cachepolicy kernel parameter instead.

cachepolicy is already doing something very different, it would not be
appropriate to use it for this.

Jason
