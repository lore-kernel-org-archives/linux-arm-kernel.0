From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 16 Oct 2015 17:40:16 +0100
Subject: [PATCH v2 1/3] xen/arm: Enable cpu_hotplug.c
In-Reply-To: <1445013301-12624-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1510161731510.27957@kaball.uk.xensource.com>
 <1445013301-12624-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <56212870.107@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 16/10/15 17:34, Stefano Stabellini wrote:
> Build cpu_hotplug for ARM and ARM64 guests.
> 
> Rename arch_(un)register_cpu to xen_(un)register_cpu and provide an
> empty implementation on ARM and ARM64. On x86 just call
> arch_(un)register_cpu as we are already doing.
> 
> Initialize cpu_hotplug on ARM.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@citrix.com>

Regards,

-- 
Julien Grall
