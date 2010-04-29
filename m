From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Apr 2010 19:28:40 +0100
Subject: Add support for the 16-way L310 L2 cache controller
In-Reply-To: <000701cae7b7$e61d45f0$b257d1d0$@deacon@arm.com>
References: <000701cae7b7$e61d45f0$b257d1d0$@deacon@arm.com>
Message-ID: <20100429182840.GI4877@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 05:20:35PM +0100, Will Deacon wrote:
> Hi Jason,
> 
> The patch entitled `Add support for the 16-way L310 L2 cache controller'
> which you submitted to RMK's patch system appears to perform a 16-way
> invalidation even when the ways might not be present. This results in
> writes to the reserved bits [15:8] of the invalidate-by-way ctrl register.
> 
> You can check the associativity by reading bit 16 of the auxiliary ctrl
> register.

I'll discard it then; seems it needs review on the mailing list.
