From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 20 Oct 2014 16:18:31 +0100
Subject: [PATCH v4 4/7] xen/arm: use is_dma_coherent
In-Reply-To: <1412941908-5850-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1413818311.29506.3.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-10 at 12:51 +0100, Stefano Stabellini wrote:
> Use is_dma_coherent to check whether we need to issue cache maintenance
> operations rather than checking on the existence of a particular
> dma_ops function for the device.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
