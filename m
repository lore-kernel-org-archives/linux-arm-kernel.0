From: liviu.dudau@arm.com (liviu.dudau at arm.com)
Date: Wed, 13 Jan 2016 10:32:34 +0000
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <4304958.38AKuZJ4gb@wuerfel>
References: <568912EE.9030009@huawei.com> <4731036.9QlepWb5cE@wuerfel>
 <20160113101028.GV13633@e106497-lin.cambridge.arm.com>
 <4304958.38AKuZJ4gb@wuerfel>
Message-ID: <20160113103234.GW13633@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:18:11AM +0100, Arnd Bergmann wrote:
> On Wednesday 13 January 2016 10:10:28 liviu.dudau at arm.com wrote:
> > 
> > OK, but from DT point of view and given the parent's #address-cells = <2> and #size-cells = <1>
> > should the reg not be something like reg = <0x1 0x0 0xe4 4> ?
> 
> No: 2+1 = 3, not 4.

Bah, not enough caffeine this morning, forgot the flags are part of the address space. Sorry for inept noise.

Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
