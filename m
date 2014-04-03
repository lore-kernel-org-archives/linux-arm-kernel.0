From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 4 Apr 2014 07:10:28 +0800
Subject: [PATCH 75/75] ARM: l2c: imx: remove direct write to power
 control register
In-Reply-To: <20140403185316.GT7528@n2100.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYaQ-0007I4-0D@rmk-PC.arm.linux.org.uk>
 <20140403063310.GG2801@dragon>
 <20140403185316.GT7528@n2100.arm.linux.org.uk>
Message-ID: <20140403231020.GA29782@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 03, 2014 at 07:53:16PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 03, 2014 at 02:33:12PM +0800, Shawn Guo wrote:
> > On Fri, Mar 28, 2014 at 03:20:50PM +0000, Russell King wrote:
> > > Now that we handle this in core code, we don't need platforms enabling
> > > the low power modes directly.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > For patches that I'm on Cc:
> > 
> > Acked-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Not a particularly helpful way to send an ack, because I don't have a
> record other than the emails on the mailing list of which to add that
> to...  I'll do my best, but I'm not going to make any guarantees of
> getting that right.

Right, it should be much easier for me to find them out than you.  They
are #5, #49, #68 and #75.

Shawn
