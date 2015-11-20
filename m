From: kernel@pfupf.net (Juergen Gross)
Date: Fri, 20 Nov 2015 15:23:00 +0100
Subject: [PATCH v5 1/7] xen: rename dom0_op to platform_op
In-Reply-To: <1448029064-22285-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511201413050.1107@kaball.uk.xensource.com>
 <1448029064-22285-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <564F2CC4.4000704@pfupf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/15 15:17, Stefano Stabellini wrote:
> The dom0_op hypercall has been renamed to platform_op since Xen 3.2,
> which is ancient, and modern upstream Linux kernels cannot run as dom0
> and it anymore anyway.

s/and/on/


Juergen

> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: konrad.wilk at oracle.com
> CC: david.vrabel at citrix.com
> CC: boris.ostrovsky at oracle.com
