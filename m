From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 24 Oct 2014 10:28:05 +0100
Subject: [PATCH v5 4/6] xen/arm/arm64: merge xen/mm32.c into xen/mm.c
In-Reply-To: <1414085246-16160-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410231821520.876@kaball.uk.xensource.com>
 <1414085246-16160-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1414142885.15687.25.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-23 at 18:27 +0100, Stefano Stabellini wrote:
> Merge xen/mm32.c into xen/mm.c.
> As a consequence the code gets compiled on arm64 too: introduce a few
> compat functions to actually be able to compile it.
> Introduce xen_is_dma_coherent on arm64 and call into the dma_ops
> functions from the xen_dma wrappers in page-coherent.h to handle
> non-coherent devices.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
