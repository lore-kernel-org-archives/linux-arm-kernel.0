From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 5 Nov 2015 17:45:06 +0000
Subject: [Xen-devel] [PATCH 3/3] xen/arm: set the system time in Xen via
 the XENPF_settime hypercall
In-Reply-To: <1446743385-12848-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <563B95A2.9010304@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/15 17:09, Stefano Stabellini wrote:
> If Linux is running as dom0, call XENPF_settime to update the system
> time in Xen on pvclock_gtod notifications.

Isn't this a cut-and-paste from x86?  Can you make it common?

David
