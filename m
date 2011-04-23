From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 22 Apr 2011 18:35:35 -0700
Subject: Common clock and dvfs
In-Reply-To: <4DB22996.8020109@codeaurora.org>
References: <BANLkTimVXbp1pFsGPcs-RPY+PTOF6ZRyoQ@mail.gmail.com>	<alpine.LFD.2.02.1104222039330.3323@ionos>
	<4DB22996.8020109@codeaurora.org>
Message-ID: <4DB22CE7.7090404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2011 06:21 PM, Saravana Kannan wrote:
> On 04/22/2011 12:37 PM, Thomas Gleixner wrote:
>> On Fri, 22 Apr 2011, Colin Cross wrote:
>>

  <snipped out the code since thunderbird is messing it up for some reason>.

> I did some crappy factorization of functions, returning -ECRAP without
> unlocking, etc, but you get the point.
>
> Whether the "level" translates to controlling power supply A or B or A &
> B is upto the implementation of dvfs_class->dvfs_update() which is per
> SOC/mach/arch.

Not sure if this was obvious from my previous email. But each 
SOC/mach/arch could have more than one dvfs_class depending on the no. 
of power supply combinations that are manipulated for dvfs.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
