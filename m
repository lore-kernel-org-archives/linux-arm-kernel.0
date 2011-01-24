From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 16:46:29 +0000
Subject: [PATCH] arm: Reset SP804 timer when initialising it as a clock
	events device
In-Reply-To: <1295887188-25924-1-git-send-email-pawel.moll@arm.com>
References: <1295887188-25924-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20110124164629.GF24104@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 04:39:48PM +0000, Pawel Moll wrote:
> The SP804 driver resets relevant timer when initialising it as
> a clock source, but it doesn't do this for clock event device.

NAK.
