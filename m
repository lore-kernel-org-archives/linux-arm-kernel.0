From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 6 Mar 2015 15:18:24 +0800
Subject: parent/child hierarchy for regulator
In-Reply-To: <20150305122234.GL21293@sirena.org.uk>
References: <20150305103534.GA19600@shlinux2>
 <20150305122234.GL21293@sirena.org.uk>
Message-ID: <20150306071823.GC12879@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 12:22:34PM +0000, Mark Brown wrote:
> On Thu, Mar 05, 2015 at 06:35:36PM +0800, Peter Chen wrote:
> 
> > Any good ways at code/dts to show parent/child hierarchy for regulator?
> 
> There's plenty of examples in mainline...
> 

Thanks, I get answer for adding parent regulator for fixed regulator,
it is very easy, we only need to add 'vin-supply = <&parent_reg>;'
at fixed's property.

-- 

Best Regards,
Peter Chen
