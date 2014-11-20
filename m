From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 20 Nov 2014 15:40:28 +0100
Subject: [PATCH v4 3/6] mfd: ti_am335x_tscadc: Remove unwanted
 reg_se_cache save
In-Reply-To: <546DF2F0.9080405@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-4-git-send-email-vigneshr@ti.com>
 <20141118143005.GF24004@x1> <20141118171240.GB3003@dtor-ws>
 <546DF2F0.9080405@ti.com>
Message-ID: <20141120144028.GB5809@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 07:26:00PM +0530, Sekhar Nori wrote:
> I tested this using lcd7 cape connected to beaglebone black. The latest
> kernel I could find on this board was a TI BSP based v3.14 kernel. So I
> had to port these patches to that kernel. Cc Robert Nelson to see if he
> knows about a more recent kernel supporting that cape.

What is missing from mainline for the black?

(I thought it was fully supported by now.)
 
> I did not see any breakage with these patches applied although I did not
> see any noticeable performance improvement as well.

So, the jumping on pen-up persists, right?  That means the patch
series does not provide a general fix for that issue.
 
> I also tested this series on AM335x EVM using the v3.18-rc5 kernel.
> Again, no breakage but no improvement as well.

You still have jumps on a pen up event?

Thanks,
Richard
