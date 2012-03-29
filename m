From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 29 Mar 2012 14:32:34 +0530
Subject: [PATCH] ARM: OMAP: hwmod: Fix error handling in functions used
 OMAP4 onwards
In-Reply-To: <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
References: <1332842311-12308-1-git-send-email-rnayak@ti.com>
 <79CD15C6BA57404B839C016229A409A83183E0CE@DBDE01.ent.ti.com>
 <4F73FD52.60209@ti.com>
 <79CD15C6BA57404B839C016229A409A83183FB9F@DBDE01.ent.ti.com>
Message-ID: <4F74252A.7060809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 March 2012 02:26 PM, Hiremath, Vaibhav wrote:
> The point I was trying to make here was, cpu_is_xxx() check will become ugly,
> as more and more devices gets added to the list, am33xx being the first one
> in omap34xx family.

So are there more, other than AM33xx which are cortex A8 based but
share the OMAP4 PRCM IP block?
