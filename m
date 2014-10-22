From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 22 Oct 2014 08:37:52 -0700
Subject: [PATCH v2 36/47] arm64: psci: Register with kernel poweroff
 handler
In-Reply-To: <20141022125230.GI22642@leverpostej>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-37-git-send-email-linux@roeck-us.net>
 <20141022125230.GI22642@leverpostej>
Message-ID: <20141022153752.GA26229@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 01:52:31PM +0100, Mark Rutland wrote:
> On Tue, Oct 21, 2014 at 05:12:52AM +0100, Guenter Roeck wrote:
> > Register with kernel poweroff handler instead of setting pm_power_off
> > directly.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> My Juno board powers down correctly with this applied, so:
> 
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> 
Thanks a lot!

Guenter
