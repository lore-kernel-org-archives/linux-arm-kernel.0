From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 27 Jan 2013 21:20:07 -0500
Subject: [PATCH 2/3] ARM: Dove: cleanup includes
In-Reply-To: <1355790269-10596-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1355790269-10596-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1355790269-10596-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130128022007.GI1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 01:24:28AM +0100, Sebastian Hesselbarth wrote:
> With DT board setup removed from common code, it is a good time
> to cleanup unneccessary includes from common dove code.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-dove/common.c |   30 +++++++++---------------------
>  1 file changed, 9 insertions(+), 21 deletions(-)

Applied to mvebu/cleanup

thx,

Jason.
