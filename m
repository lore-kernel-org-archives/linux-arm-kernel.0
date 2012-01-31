From: daniel.lezcano@free.fr (Daniel Lezcano)
Date: Tue, 31 Jan 2012 15:13:04 +0100
Subject: [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <4F200BE2.2070301@free.fr>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org>
 <CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
 <4F200BE2.2070301@free.fr>
Message-ID: <4F27F6F0.7010508@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 03:04 PM, Daniel Lezcano wrote:
> On 01/20/2012 09:40 PM, Colin Cross wrote:
>> On Fri, Jan 20, 2012 at 12:46 AM, Daniel Lezcano
>> <daniel.lezcano@linaro.org>  wrote:
>>> Hi Colin,
>>>
>>> this patchset could be interesting to resolve in a generic way the cpu
>>> dependencies.
>>> What is the status of this patchset ?
>> I can't do much with it right now, because I don't have any devices
>> that can do SMP idle with a v3.2 kernel.  I've started working on an
>> updated version that avoids the spinlock, but it might be a while
>> before I can test and post it.  I'm mostly looking for feedback on the
>> approach taken in this patch, and whether it will be useful for other
>> SoCs besides Tegra and OMAP4.
>
> Hi Colin,
>
> I will be happy to test your patchset. Do you have a pointer to a more 
> recent kernel ?

Hi Colin,

sorry for bothering you. I am working on a cpuidle driver for an ARM SMP 
board, I will be really happy to test your patchset and look how it fits 
with the cpuidle driver.

Thanks
   -- Daniel
