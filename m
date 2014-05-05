From: davem@davemloft.net (David Miller)
Date: Mon, 05 May 2014 13:19:18 -0400 (EDT)
Subject: [PATCH v2 0/6] Add CPTS support for AM437x 
In-Reply-To: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
References: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
Message-ID: <20140505.131918.1426781180793240906.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George Cherian <george.cherian@ti.com>
Date: Fri, 2 May 2014 12:01:58 +0530

> The series adds CPTS support for AM4372.
> 
> Patch 1 - DT changes w.r.t clock changes for AM33xx.
> Patch 2 - CPTS clock name harcoding in the driver is removed. 
> 	  Easier to pass the clock name from dt rather than hardcoding in driver.
> 	  Also in prepration for DRA7x CPTS support.
> Patch 3 - Enable the CPTS support for both DRA7x and AM4372 in the driver.
> Patch 4 - Enable the Annexe F for L2 PTP for AM437x and DRA7x.
> Patch 5 - Change the default clocksource to dpll_core_m5 
> Patch 6 - DT changes for AM4372.
> 
> v1 -> v2
> 	Patch 1 and 2 Re-ordering.
> 	Seperate TS_BITS define for Hw version V2 and V3

Series applied, thanks.
