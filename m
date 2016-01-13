From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 11:18:11 +0100
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <20160113101028.GV13633@e106497-lin.cambridge.arm.com>
References: <568912EE.9030009@huawei.com> <4731036.9QlepWb5cE@wuerfel>
 <20160113101028.GV13633@e106497-lin.cambridge.arm.com>
Message-ID: <4304958.38AKuZJ4gb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 January 2016 10:10:28 liviu.dudau at arm.com wrote:
> 
> OK, but from DT point of view and given the parent's #address-cells = <2> and #size-cells = <1>
> should the reg not be something like reg = <0x1 0x0 0xe4 4> ?

No: 2+1 = 3, not 4.

	Arnd
