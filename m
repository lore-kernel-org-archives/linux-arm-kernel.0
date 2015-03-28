From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 28 Mar 2015 15:59:14 +0000
Subject: [PATCH] dtbsinstall: don't move target directory out of the way
In-Reply-To: <E1YbqvP-000283-5m@rmk-PC.arm.linux.org.uk>
References: <20150328132320.GA24391@n2100.arm.linux.org.uk>
 <E1YbqvP-000283-5m@rmk-PC.arm.linux.org.uk>
Message-ID: <20150328155913.GB25778@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 28, 2015 at 01:37:19PM +0000, Russell King wrote:
> No other kernel installation target moves the target directory out of
> the way, even deleting an old version of it.  These are destructive
> operations, ones which the kernel build system should not be making.
> 
> Remove this behaviour.
> 
> If this behaviour is required at installation time, this should be
> done by the installation external to the kernel makefiles, just like
> it would be done for 'make modules_install'.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  scripts/Makefile.dtbinst | 2 --
>  1 file changed, 2 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
