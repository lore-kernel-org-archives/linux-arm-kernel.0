From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Thu, 12 Nov 2015 10:23:24 -0500
Subject: [PATCH v3 1/6] xen: rename dom0_op to platform_op
In-Reply-To: <1447260696-450-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511111639500.5676@kaball.uk.xensource.com>
 <1447260696-450-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <5644AEEC.7030408@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2015 11:51 AM, Stefano Stabellini wrote:
> The dom0_op hypercall has been renamed to platform_op since Xen 3.2,
> which is ancient, and modern upstream Linux kernels cannot run as dom0
> and it anymore anyway.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: konrad.wilk at oracle.com
> CC: david.vrabel at citrix.com
> CC: boris.ostrovsky at oracle.com

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
