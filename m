From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 6 Nov 2014 10:51:58 -0800
Subject: [PATCH v5 36/48] arm64: psci: Register with kernel power-off
 handler
In-Reply-To: <20141106172222.GA15384@leverpostej>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
 <1415292213-28652-37-git-send-email-linux@roeck-us.net>
 <20141106172222.GA15384@leverpostej>
Message-ID: <20141106185158.GC31712@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 05:22:23PM +0000, Mark Rutland wrote:
> On Thu, Nov 06, 2014 at 04:43:20PM +0000, Guenter Roeck wrote:
> > Register with kernel power-off handler instead of setting pm_power_off
> > directly.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> I just fetched your current poweroff-handler branch and gave it a spin
> on Juno. It looks like this hasn't broken since the last time I tried
> it. :)
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
Thanks a lot!

Guenter
