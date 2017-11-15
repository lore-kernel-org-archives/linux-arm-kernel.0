From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 15 Nov 2017 09:15:15 -0600
Subject: Fwd: [PATCH 2/4] gpiolib: add bitmask for valid GPIO lines
In-Reply-To: <1510745919.25007.234.camel@linux.intel.com>
References: <1510096056-13765-3-git-send-email-timur@codeaurora.org>
 <b2b5374b-17a6-e068-ef8b-edc90d34c352@codeaurora.org>
 <20171115062837.GA22802@codeaurora.org>
 <1510745919.25007.234.camel@linux.intel.com>
Message-ID: <98107fc7-d5b4-9347-4713-868414c5e41f@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2017 05:38 AM, Andy Shevchenko wrote:
> I suppose you meant kmalloc_array.
> Anyway, it's a separate change if you wish, because Timur didn't change
> the original approach here.

Unfortunately for me, all of the irq stuff has moved into its own 
structure in 4.15, so I need to rewrite all this code anyway.  I'll drop 
the use of kcalloc.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
