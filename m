From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jan 2012 23:29:50 +0000
Subject: [PATCH v2 14/15] ARM: local timers: convert MSM to runtime
 registration interface
In-Reply-To: <20120113232659.GA20638@codeaurora.org>
References: <1326479322-6033-1-git-send-email-marc.zyngier@arm.com>
 <1326479322-6033-15-git-send-email-marc.zyngier@arm.com>
 <20120113232659.GA20638@codeaurora.org>
Message-ID: <20120113232950.GK1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 03:26:59PM -0800, David Brown wrote:
> On Fri, Jan 13, 2012 at 06:28:41PM +0000, Marc Zyngier wrote:
> 
> > +static struct local_timer_ops msm_local_timer_ops __initdata = {
> 
> This needs to be __cpuinitdata.  With that change, you can put the
> tested and acked-by back.

Marc,

There's a bunch of similar problems throughout this patch set - could
you look through them and fix please?
