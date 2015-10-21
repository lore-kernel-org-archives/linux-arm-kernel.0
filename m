From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 21 Oct 2015 12:55:41 +0100
Subject: [Xen-devel] [PATCH v4 3/3] xen/arm: don't try to re-register
 vcpu_info on cpu_hotplug.
In-Reply-To: <1445428430-21567-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1510211251370.27957@kaball.uk.xensource.com>
 <1445428430-21567-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <56277D3D.20107@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 21/10/15 12:53, Stefano Stabellini wrote:
> Call disable_percpu_irq on CPU_DYING and enable_percpu_irq when the cpu
> is coming up.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@citrix.com>

Regards,

-- 
Julien Grall
