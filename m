From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 22 Oct 2014 08:38:07 -0700
Subject: [PATCH v2 36/47] arm64: psci: Register with kernel poweroff
 handler
In-Reply-To: <20141022112300.GA15370@e104818-lin.cambridge.arm.com>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-37-git-send-email-linux@roeck-us.net>
 <20141022112300.GA15370@e104818-lin.cambridge.arm.com>
Message-ID: <20141022153807.GB26229@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 22, 2014 at 12:23:03PM +0100, Catalin Marinas wrote:
> On Tue, Oct 21, 2014 at 05:12:52AM +0100, Guenter Roeck wrote:
> > Register with kernel poweroff handler instead of setting pm_power_off
> > directly.
> > 
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

Guenter
