From: dvrabel@cantab.net (David Vrabel)
Date: Thu, 26 Jul 2012 17:56:15 +0100
Subject: [Xen-devel] [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <501176AF.3000607@cantab.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/12 16:33, Stefano Stabellini wrote:
> 
> + * The hvc ISS is required to be 0xEA1, that is the Xen specific ARM
> + * hypercall tag.

Is this number, 0xea1, assigned to Xen by some external body?

David
