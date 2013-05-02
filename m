From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 2 May 2013 09:19:14 +0100
Subject: [Xen-devel] [PATCH 2/3] xen: move do_stolen_accounting to
 drivers/xen/time.c
In-Reply-To: <1367436460-10183-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305011939180.5398@kaball.uk.xensource.com>
 <1367436460-10183-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1367482754.21869.25.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-05-01 at 20:27 +0100, Stefano Stabellini wrote:
> Move do_stolen_accounting, xen_vcpu_stolen and related functions and
> static variables to common code (drivers/xen/time.c).
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

> +	/* work out how much time the VCPU has not been runn*ing*  */

I wonder what this emphasis on runn*ing* means?

Ian.
