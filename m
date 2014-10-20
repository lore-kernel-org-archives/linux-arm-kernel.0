From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 20 Oct 2014 16:19:05 +0100
Subject: [PATCH v4 5/7] xen/arm/arm64: merge xen/mm32.c into xen/mm.c
In-Reply-To: <1412941908-5850-5-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-5-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1413818345.29506.4.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-10 at 12:51 +0100, Stefano Stabellini wrote:
> Merge xen/mm32.c into xen/mm.c.
> As a consequence the code gets compiled on arm64 too: introduce a few
> compat functions to actually be able to compile it.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
