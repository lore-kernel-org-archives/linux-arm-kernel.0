From: post@twien.net (post at twien.net)
Date: Thu, 23 Oct 2014 14:57:45 +0200
Subject: ARMADA 370 - Distributed Switch Architecture (dsa) - device tree
In-Reply-To: <20141023121034.GJ17447@titan.lakedaemon.net>
References: <f1e8d1ba750bfb63f84471d0ec7de988@twien.net>
 <20141013111904.GD14147@titan.lakedaemon.net>
 <20141023112002.228d8a17@free-electrons.com>
 <20141023121034.GJ17447@titan.lakedaemon.net>
Message-ID: <3328a23fffe41f90f0660b26e36e412a@twien.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,
It's progressing. Have had little time to work on it lately, but have 
got the 6352 switch up and running except for port 6 (the one with 
external PHY). It's currently commented out in my device tree 
specification. Enabling port 6 in the .dts file causes the dsa setup to 
fail (error -5).
BR,
Tormod

On 2014-10-23 14:10, Jason Cooper wrote:
> On Thu, Oct 23, 2014 at 11:20:02AM +0200, Thomas Petazzoni wrote:
>> Hello all,
>> 
>> I'm catching up on some past e-mails. Has this DSA issue been 
>> resolved?
>> I thought Andrew has done some DSA related work at some point? If not,
>> we could also involve Florian Fainelli in the loop, as he has done
>> quite a bit of DSA related stuff if I remember correctly.
> 
> The discussion is slow, but ongoing, but not underneath this email I
> sent out.  Parent is here:
> 
>   https://lkml.kernel.org/r/f1e8d1ba750bfb63f84471d0ec7de988 at twien.net
> 
> thx,
> 
> Jason.
