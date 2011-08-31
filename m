From: B04825@freescale.com (Tabi Timur-B04825)
Date: Wed, 31 Aug 2011 11:55:39 +0000
Subject: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
	checking for each DAIs separately
In-Reply-To: <4E5E1285.8020508@ti.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E5E1285.8020508@ti.com>
Message-ID: <4E5E213A.8040909@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liam Girdwood wrote:
> Timur, iirc your driver has some special symmetry requirement (maybe something todo with having 2 DAIs) ?
>
> I assume this is OK for you too ?

Yes, that's why I was asking.  I believe I'm affected by this patch as 
well, so I will test it.  However, I never noticed a problem before, so 
I'm not sure what's going on.

-- 
Timur Tabi
Linux kernel developer at Freescale
