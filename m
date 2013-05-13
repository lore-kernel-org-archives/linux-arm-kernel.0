From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 12:04:33 -0400
Subject: [PATCH] ARM: plat-orion: add missing ehci include to common.h
In-Reply-To: <1368216747-28898-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1368216747-28898-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130513160433.GP31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 10:12:27PM +0200, Sebastian Hesselbarth wrote:
> Removing orion ehci include from board files will raise a compiler
> error because plat/common.h is using an enum provided by orion ehci
> but not including the include itself. This just adds the missing include.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/plat-orion/include/plat/common.h |    1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/fixes

thx,

Jason.
