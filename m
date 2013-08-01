From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 1 Aug 2013 12:34:04 +0100
Subject: [PATCH RFC 6/8] xen: make xen_create_contiguous_region return
 the dma address
In-Reply-To: <1375292732-7627-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1307311833040.4893@kaball.uk.xensource.com>
 <1375292732-7627-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <51FA47AC.2020507@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/13 18:45, Stefano Stabellini wrote:
> Modify xen_create_contiguous_region to return the dma address of the
> newly contiguous buffer.

Seems sensible.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
