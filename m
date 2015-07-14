From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 14 Jul 2015 17:53:47 +0100
Subject: [PATCH v2 09/10] arm64/BUG: Use BRK instruction for generic BUG
 traps
In-Reply-To: <20150714155127.GD12675@leverpostej>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-10-git-send-email-Dave.Martin@arm.com>
 <20150713164315.GC22840@leverpostej>
 <20150713165151.GC10670@e103592.cambridge.arm.com>
 <20150713165638.GD22840@leverpostej>
 <20150714102025.GD10670@e103592.cambridge.arm.com>
 <20150714110904.GB12675@leverpostej>
 <20150714113435.GE10670@e103592.cambridge.arm.com>
 <20150714155127.GD12675@leverpostej>
Message-ID: <20150714165347.GG10670@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 04:51:27PM +0100, Mark Rutland wrote:
> On Tue, Jul 14, 2015 at 12:34:35PM +0100, Dave P Martin wrote:

[...]

> > I could repeat it on every line and rearrange/reindent things so that
> > __BUGVERBOSE doesn't get in the way of the labels, but IMHO that's
> > uglier and not really more readable.
> > 
> > Are we getting into dimishing returns here?
> 
> I guess so.
> 
> For any of the variants posted in this thread so far:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

OK, thanks.
---Dave
