From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 28 Aug 2013 13:09:30 -0500
Subject: [PATCH v3 2/2] ARM: dts: msm: Update uartdm compatible strings
In-Reply-To: <0092782E-9E89-4350-B3B5-EB1275F2F8E3@codeaurora.org>
References: <1377648764-23453-1-git-send-email-sboyd@codeaurora.org>
 <1377648764-23453-3-git-send-email-sboyd@codeaurora.org>
 <0092782E-9E89-4350-B3B5-EB1275F2F8E3@codeaurora.org>
Message-ID: <73376D74-0D5C-4739-A81A-1A1EC7B3463F@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 28, 2013, at 1:04 PM, Kumar Gala wrote:

> 
> On Aug 27, 2013, at 7:12 PM, Stephen Boyd wrote:
> 
>> Let's follow the ratified DT binding and use uartdm instead of
>> hsuart. This does break backwards compatibility but this
>> shouldn't be a problem because the uart driver isn't probing on
>> these devices without adding clock support (which isn't merged so
>> far).
> 
> I'm not seeing any driver upstream even using the compatibles so might be worth adding that we aren't even breaking anything upstream.
> 
> Otherwise you can add:

Ignore me, not sure what tree I was looking at.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
