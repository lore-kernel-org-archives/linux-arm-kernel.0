From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 22:01:44 +0530
Subject: BogoMIPS change in 3.6+
In-Reply-To: <20130131162523.GE835@mudshark.cambridge.arm.com>
References: <510A988F.6030508@gmail.com> <510A9AD8.8060003@ti.com>
 <20130131162523.GE835@mudshark.cambridge.arm.com>
Message-ID: <510A9C70.8090606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 09:55 PM, Will Deacon wrote:
> On Thu, Jan 31, 2013 at 04:24:56PM +0000, Santosh Shilimkar wrote:
>> On Thursday 31 January 2013 09:45 PM, Rob Herring wrote:
>>> The BogoMIPS value has changed on highbank since the commit below in
>>> 3.6. It is now half the value it used to be. Does that matter other than
>>> perception (I've checked that I'm not running at half the freq)?
>>>
>> I also stumbled on this while testing Will's series.[1]
>> There should be no other functional issue apart from getting surprised.
>
> Right, but you were using the arch-timers w/ Cortex-A15. I thought Highbank
> was A9?
>
Ahh.. Sorry looking at description I just thought it could be the same
issue.

Regards,
Santosh
