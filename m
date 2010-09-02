From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 12:11:58 +0100
Subject: [PATCH 14/24] msm: add hotplug stub functions
In-Reply-To: <1282712273-344-15-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-15-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100902111157.GX26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 09:57:43PM -0700, Jeff Ohlstein wrote:
> From: Daniel Walker <dwalker@codeaurora.org>
> 
> We don't actually do anything for hotplug yet. This just lets
> everything compile, even when hotplug is enabled.

And the point of that is?  If you're not supporting hotplug CPU yet, then
don't allow it to be enabled.
