From: davidb@codeaurora.org (David Brown)
Date: Wed, 24 Jul 2013 15:41:26 -0700
Subject: [PATCH 0/3] MSM gpio fixes
In-Reply-To: <CACRpkdbOO8fFEx+PxsdJ9F1dqD6V4_RPZThvTufo9+XhhyuHOg@mail.gmail.com>
References: <1374178035-19943-1-git-send-email-davidb@codeaurora.org>
 <CACRpkdbOO8fFEx+PxsdJ9F1dqD6V4_RPZThvTufo9+XhhyuHOg@mail.gmail.com>
Message-ID: <20130724224126.GA27678@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 20, 2013 at 10:54:42PM +0200, Linus Walleij wrote:
>On Thu, Jul 18, 2013 at 10:07 PM, David Brown <davidb@codeaurora.org> wrote:
>
>> Rohit sent these three fixes out on June 18.  I still need a
>> devicetree ack for the first patch, and would like these to get pulled
>> in for v3.11
>>
>> Rohit Vaswani (3):
>>   ARM: msm: dts: Fix the gpio register address for msm8960
>>   drivers: gpio: msm: Fix the error condition for reading ngpio
>
>OK for these two...
>
>>   ARM: msm: Consolidate gpiomux for older architectures
>
>This does not look like a fix? Surely this can wait for v3.12?

It fixes compilation.  But, it could also wait for v3.12.

David

-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
