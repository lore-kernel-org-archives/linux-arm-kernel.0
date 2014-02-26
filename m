From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 26 Feb 2014 08:49:50 -0500
Subject: [RFC PATCH 1/1] arm64: Add support for 48-bit Physical Address
In-Reply-To: <1393394310-6138-2-git-send-email-mohun106@gmail.com>
References: <1393394310-6138-1-git-send-email-mohun106@gmail.com>
 <1393394310-6138-2-git-send-email-mohun106@gmail.com>
Message-ID: <530DF0FE.3050602@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Radha,

On 02/26/2014 12:58 AM, mohun106 at gmail.com wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> Added support for ARMv8 platforms that have 48-bit physical address
> implemented. There is no change in the VA bits and levels of
> translation.

Is there benefit to using build-time constants for this information? Why not
look up the physical address range at run time, so that a single kernel binary
could run on any system?

Thanks,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
