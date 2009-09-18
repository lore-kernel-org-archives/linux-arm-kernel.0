From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Sep 2009 20:35:27 +0100
Subject: [PATCH] locomo.c: CodingStyle cleanups
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901CBF46C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF46C@mi8nycmail19.Mi8.com>
Message-ID: <20090918193527.GB6601@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2009 at 08:31:00PM -0400, H Hartley Sweeten wrote:
> EXPORT* macros should follow immediately after the closing function
> brace line.
> 
> The prototype for locomo_chip_driver() is not needed since the static
> (inline) function is located earlier in the file.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: John Lenz <lenz@cs.wisc.edu>
> 
> ---
> 
> I originally sent this to the wrong list...

Ok.  I guess as there isn't a specific sa11x0 maintainer, it might as well
go to the patch system direct.  (and might as well drop John's CC)
