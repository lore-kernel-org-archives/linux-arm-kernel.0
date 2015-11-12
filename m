From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 20:14:02 +0100
Subject: [PATCH v4 7/7] xen/x86: support XENPF_settime64
In-Reply-To: <1447349448-22610-7-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-7-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <183176527.4Fm2KVc0q4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 17:30:48 Stefano Stabellini wrote:
> Try XENPF_settime64 first, if it is not available fall back to
> XENPF_settime32.
> 
> No need to call __current_kernel_time() when all the info needed are
> already passed via the struct timekeeper * argument.
> 
> Return NOTIFY_BAD in case of errors.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: konrad.wilk at oracle.com
> CC: david.vrabel at citrix.com
> CC: boris.ostrovsky at oracle.com
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
