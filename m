From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Jun 2016 09:21:57 +0100
Subject: [RFC PATCH] clocksource: arm_arch_timer: disable the evtstrm via
 the cmdline
In-Reply-To: <5766FBC6.6000405@linaro.org>
References: <1466171011-30468-1-git-send-email-will.deacon@arm.com>
 <5766FBC6.6000405@linaro.org>
Message-ID: <20160620082157.GC29165@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 19, 2016 at 10:08:38PM +0200, Daniel Lezcano wrote:
> On 06/17/2016 03:43 PM, Will Deacon wrote:
> 
> [ Cc'ed tglx ]
> 
> >Disabling the eventstream can be useful for debugging and development
> >purposes
> 
> If it is for debugging and development, why upstream this change ?

Mainly because it's desirable to be able to debug systems remotely, on
machines that you don't have direct access to and where recompiling the
kernel isn't necessarily an option. There are plenty of "no*" kernel
parameters already that fall into a similar category.

Will
