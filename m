From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Jan 2011 16:38:37 +0000
Subject: [PATCH v4] ARM: Thumb-2: Symbol manipulation macros for
	function body copying
In-Reply-To: <AANLkTimZGvsEEnLqYoNkZ1L0Rw+5K5O2Gsc0x-5Lj-dx@mail.gmail.com>
References: <1295039877-7976-1-git-send-email-dave.martin@linaro.org>
	<AANLkTintFe4V6BxrUxh-gwvhoa=RcH0tkHjYbfyGHKD=@mail.gmail.com>
	<20110117160136.GA25829@n2100.arm.linux.org.uk>
	<AANLkTimZGvsEEnLqYoNkZ1L0Rw+5K5O2Gsc0x-5Lj-dx@mail.gmail.com>
Message-ID: <20110126163837.GA7323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 04:05:33PM +0000, Dave Martin wrote:
> Hi Russell,
> 
> I tried to send this patch to your patch system, but I've received no
> response or any bounce.  On my end the mail appears to have been sent,
> and previous submissions made via the same route have succeeded.
> 
> The patch doesn't seem to be in the patch system, but I'm not sure
> what went wrong ... hopefully I'm not doing anything stupid.
> 
> Do you have any ideas what might have gone wrong?

Probably the lack of a line matching '^PATCH\s+FOLLOWS\s*$', '^--[- ]$'.

It's rather particular about that before it'll even consider sending a
reply,  It's a measure to prevent excessive collateral spam and my MTA
being blacklisted as a result.
