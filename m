From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 May 2014 15:18:12 -0700
Subject: [RFC] ARM: tty: Move HVC DCC assembly to arch/arm
In-Reply-To: <537E74C1.7020509@codeaurora.org>
References: <1382120064-2459-1-git-send-email-cov@codeaurora.org>
 <52617F22.6030900@codeaurora.org> <537E74C1.7020509@codeaurora.org>
Message-ID: <537E77A4.908@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/22/14 15:05, Christopher Covington wrote:
> Hi Stephen,
>
> On 10/18/2013 02:34 PM, Stephen Boyd wrote:
>> On 10/18/13 11:14, Christopher Covington wrote:
>>> Put architecture-specific assembly code where it belongs,
>>> allowing for support of additional architectures such as arm64 in
>>> the future.
>> Do you have that patch too? There was also a patch a year ago to add
>> armv5/v4 support to this driver. Maybe we can resurrect that too.
> I still haven't gotten around to testing that one.

It would be nice if that patch was sent along with this one, or if you
have some armv8 patch that works too. This patch by itself doesn't seem
too useful because we're just moving code around in preparation for
supporting this driver on multiple arches.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
