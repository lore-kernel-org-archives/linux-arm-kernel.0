From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 28 Jan 2011 18:21:17 -0600
Subject: [RFC] add pwmlib support
In-Reply-To: <20110128141216.GA6374@trinity.fluff.org>
References: <1296217283-14531-1-git-send-email-s.hauer@pengutronix.de>
	<20110128141216.GA6374@trinity.fluff.org>
Message-ID: <AANLkTincgZadM7hbb6dT+JkxcgUHwuEoragvjfFj+fJa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 8:12 AM, root <ben@fluff.org> wrote:
>
> On Fri, Jan 28, 2011 at 01:21:21PM +0100, Sascha Hauer wrote:
>> Hi all,
>>
>> While implementing just another pwm driver I thought it's time to implement
>> generic pwm support. The following series adds drivers/pwm/pwmlib.c and
>> a i.MX23/28 pwm driver which serves as a usage example for pwmlib. The
>> code is inspired by gpiolib support and tested using the backlight pwm
>> driver by Eric Miao.
>
> You know, I really wish driver cores like this where not called lib... it
> is hardly as if they can be taken out of the kernel and usefully re-used
> in another project.

Well, I've never known a collection of code shared across multiple
client applications with the specific intent of consolidating
functonality under a single framework to be called many other things
than a "library". It doesn't matter what address space it's in, it's a
library of reusable code, so I think the name stands up.

Sascha, this is awesome, BTW. I'm going to see if I can get PWM for
MX5x and MC13892 under this..

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
