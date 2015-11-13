From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 13 Nov 2015 13:43:07 +0000
Subject: [Xen-devel] [PATCH v4 4/7] arm: extend pvclock_wall_clock with
 sec_hi
In-Reply-To: <1447349448-22610-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <5645E8EB.7060601@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 12/11/15 17:30, Stefano Stabellini wrote:
> The hypervisor actually exposes an additional field to struct
> pvclock_wall_clock, with the high 32 bit seconds.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Reviewed-by: Julien Grall <julien.grall@citrix.com>

Regards,

-- 
Julien Grall
