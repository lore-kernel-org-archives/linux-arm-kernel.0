From: nm@ti.com (Nishanth Menon)
Date: Fri, 12 Dec 2014 13:40:01 -0600
Subject: ARM: OMAP5/DRA7: Fix counter frequency drift for AM572x errata
 i856
In-Reply-To: <20141212192303.GY24110@csclub.uwaterloo.ca>
References: <20141211204116.GT24110@csclub.uwaterloo.ca>
 <20141211204308.GU24110@csclub.uwaterloo.ca>
 <548B27E5.4090108@ti.com>
 <20141212192303.GY24110@csclub.uwaterloo.ca>
Message-ID: <20141212194001.GA30966@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:23-20141212, Lennart Sorensen wrote:
> I was trying to avoid making the code mroe complicated for the other
> CPUs using this code, but I suppose since it runs only at boot once,
> that probably isn't really a great concern.

we try and avoid soc_is or cpu_is as much as possible and depend usually
on compatible to mark the change..
> 
> I will try changing the flow and send an updated version.

k, thanks. lets go through your next rev to see if we can improve on the
same. btw, nice catch :) - thanks for proposing a fix.
-- 
Regards,
Nishanth Menon
