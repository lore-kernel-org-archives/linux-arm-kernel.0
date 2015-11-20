From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Fri, 20 Nov 2015 09:35:15 -0500
Subject: [PATCH v5 7/7] xen/x86: support XENPF_settime64
In-Reply-To: <1448029064-22285-7-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
 <1448029064-22285-7-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <564F2FA3.6010603@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2015 09:17 AM, Stefano Stabellini wrote:
> Try XENPF_settime64 first, if it is not available fall back to
> XENPF_settime32.
>
> No need to call __current_kernel_time() when all the info needed are
> already passed via the struct timekeeper * argument.
>
> Return NOTIFY_BAD in case of errors.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
