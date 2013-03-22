From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 22 Mar 2013 10:58:37 +0530
Subject: [RFC 0/8]: omap4: clk: move clock data under drivers/clk
In-Reply-To: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
References: <1363887347-4686-1-git-send-email-t-kristo@ti.com>
Message-ID: <514BEC05.3050105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero,

On Thursday 21 March 2013 11:05 PM, Tero Kristo wrote:
> Hi,
> 
> This is an RFC version of the clock data move under drivers/clk.
> Tested under 3.8 and boots fine, but don't try this out unless
> you are experimental sort (I quickly tried with 3.9-rc3 and it failed to
> boot with that.)
> 
> The approach taken here has minimal impact on the clock data
> and should make it easy to transfer clock data for omap2 / omap3 and
> omap5 also. omap4 was only done as a proof of concept.
> 
> Any comments appreciated.

I strangely only see the cover letter delivered to me and no
patches. Do you have a branch with the patches which you can
share?

regards,
Rajendra
 
> 
> -Tero
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
