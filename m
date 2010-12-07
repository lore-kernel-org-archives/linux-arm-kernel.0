From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 7 Dec 2010 21:43:40 +0100
Subject: [PATCH 11/14] OMAP4: PRCM: reorganize existing OMAP4 PRCM header
	files
In-Reply-To: <20101207012514.3708.87532.stgit@twilight.localdomain>
References: <20101207012242.3708.45451.stgit@twilight.localdomain>
	<20101207012514.3708.87532.stgit@twilight.localdomain>
Message-ID: <4CFE9C7C.6060101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/7/2010 2:25 AM, Paul Walmsley wrote:

[...]

> + *
> + * XXX This file needs to be updated to align on one of "OMAP4", "OMAP44XX",
> + *     or "OMAP4430".

Yep, I was thinking to change that as well. My first thought was OMAP4 
to get a shorter name, but when we will introduce OMAP4440, we might 
have some new entries, that will looks ugly close to OMAP4.
So at the end I will prefer OMAP44XX for the moment and we might renamed 
to OMAP4430 or OMAP4440 for the entries that will diverge.

Do you want to change that for 2.6.38?
It will require some sync with the various users of these defines, but 
that should be doable.

Regards,
Benoit
