From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 24 Oct 2014 10:23:12 +0100
Subject: [PATCH v5 2/6] xen/arm: remove outer_*_range call
In-Reply-To: <1414085246-16160-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410231821520.876@kaball.uk.xensource.com>
 <1414085246-16160-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1414142592.15687.22.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-23 at 18:27 +0100, Stefano Stabellini wrote:
> Dom0 is not actually capable of issuing outer_inv_range or
> outer_clean_range calls.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
