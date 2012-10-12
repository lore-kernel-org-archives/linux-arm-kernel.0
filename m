From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 14:32:04 +0100
Subject: [PATCH 0/2] ARM: sort configuration files
In-Reply-To: <20121012132553.GK28061@n2100.arm.linux.org.uk>
References: <20121012132553.GK28061@n2100.arm.linux.org.uk>
Message-ID: <20121012133203.GL28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2012 at 02:25:53PM +0100, Russell King - ARM Linux wrote:
> Here's a version updated to the kernel as of 7am UTC today.  Two patches
> follow, the second fixes the order of the platform choice.

Having just spoken to Arnd, it seems that now is probably a good time
to send this to Linus; arm-soc is empty apart from a few fixes which
shouldn't clash with this.

So now is the time to really check that these patches don't cause *you*
any problems.  This is definitely one of those patches where "many eyes"
is the only way to check it.  I'll put them into my nightly test builds,
and if it all looks good, I'll send it to Linus tomorrow.

That means, I will now accept acks/review tags for these, but the window
for getting those in will be _short_.
