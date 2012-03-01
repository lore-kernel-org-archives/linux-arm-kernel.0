From: sameo@linux.intel.com (Samuel Ortiz)
Date: Thu, 1 Mar 2012 12:39:44 +0100
Subject: [PATCH 1/5] mfd : ux500 - Cleanup duplicate definitions
In-Reply-To: <1330465569-567-1-git-send-email-daniel.lezcano@linaro.org>
References: <1330465569-567-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120301113944.GJ9008@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Feb 28, 2012 at 10:46:05PM +0100, daniel.lezcano at linaro.org wrote:
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> I missed in my previous patch the A9_MASK_REQ[_MASK] were
> already defined. Let's remove the duplicate definitions.
> 
> The PRCMU_GIC_DELAY macro could be removed as it is not
> really useful here.
This one and the 4 other patches applied. Thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
