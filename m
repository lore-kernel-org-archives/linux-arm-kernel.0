From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Nov 2015 21:35:04 +0100
Subject: [PATCH v3 6/6] xen/arm: set the system time in Xen via the
 XENPF_settime64 hypercall
In-Reply-To: <1447260696-450-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
 <1447260696-450-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <4497434.eqiq2DWK3j@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 November 2015 16:51:36 Stefano Stabellini wrote:
> If Linux is running as dom0, call XENPF_settime64 to update the system
> time in Xen on pvclock_gtod notifications.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
