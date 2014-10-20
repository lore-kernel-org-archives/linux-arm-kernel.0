From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Mon, 20 Oct 2014 16:14:08 +0100
Subject: [PATCH v4 1/7] xen/arm: remove handling of
 XENFEAT_grant_map_identity
In-Reply-To: <1412941908-5850-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410101244090.17038@kaball.uk.xensource.com>
 <1412941908-5850-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1413818048.13796.28.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-10-10 at 12:51 +0100, Stefano Stabellini wrote:
> The feature has been removed from Xen. Also Linux cannot use it on ARM32
> without CONFIG_ARM_LPAE.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Reviewed-by: David Vrabel <david.vrabel@citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>
