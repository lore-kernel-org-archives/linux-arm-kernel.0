From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 26 Apr 2016 09:17:43 +0100
Subject: [PATCH 0/3] ARM: nommu: R-class fixes
In-Reply-To: <20160425133012.GA4085@afzalpc>
References: <1461325416-29570-1-git-send-email-vladimir.murzin@arm.com>
 <20160423065431.GA5840@afzalpc> <571DCD8D.8070605@arm.com>
 <55296515.n2D97kIgVc@wuerfel> <20160425133012.GA4085@afzalpc>
Message-ID: <571F2427.5030003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 14:30, Afzal Mohammed wrote:
> Hi,
> 
> On Mon, Apr 25, 2016 at 02:59:13PM +0200, Arnd Bergmann wrote:
>> On Monday 25 April 2016 08:55:57 Vladimir Murzin wrote:
> 
>> What hardware platform do you use? It would be nice to make it a little
>> more explicit which platforms can use the ARMv7-R, or an ARMv7-A with
>> the MMU disabled.
> 
> And for compiling user space, which toolchain is being used ? (i am
> quite shaky on this question, since !MMU, assuming that the normal one
> used for Cortex-A userspace can't be used)

I built myself, but there are prebild tools available at [1] although
I've never tried them.

It seems to me there have been internal patches to support FDPIC [2],
but I don't know what happen afterwards :(

[1] https://launchpad.net/gcc-arm-embedded
[2]
http://connect.linaro.org/resource/sfo15/sfo15-406-arm-fdpic-toolset-kernel-libraries-for-cortex-m-cortex-r-mmuless-cores/

Cheers
Vladimir

> 
> Regards
> afzal
> 
> 
