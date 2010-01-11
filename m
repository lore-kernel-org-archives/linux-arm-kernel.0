From: dwalker@codeaurora.org (Daniel Walker)
Date: Mon, 11 Jan 2010 15:17:30 -0800
Subject: [RFC 11/18] arm: msm: add ARCH_MSM_SCORPION to CPU_V7
In-Reply-To: <20100111231327.GG7925@n2100.arm.linux.org.uk>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-12-git-send-email-dwalker@codeaurora.org>
	<20100111231327.GG7925@n2100.arm.linux.org.uk>
Message-ID: <1263251850.26505.37.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-11 at 23:13 +0000, Russell King - ARM Linux wrote:
> You don't understand what's going on here.  You want to offer
> the question "Support ARM V7 processor" to the user, and it's
> acceptable on Scorpion to say "no" to this?
> 
> I think not.  Do it in the same way other platforms do it, and
> select CPU_V7 from ARCH_MSM_SCORPION - if you have Scorpion, then
> surely V7 CPU support is mandatory.
> 
> You only add to the 'if' line if the support is optional for your
> platform.

Ok .. I'll drop this one ..

Daniel
