From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 18:19:46 +0100
Subject: [Xen-devel] [PATCH 02/24] xen/arm: hypercalls
In-Reply-To: <501176AF.3000607@cantab.net>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-2-git-send-email-stefano.stabellini@eu.citrix.com>
 <501176AF.3000607@cantab.net>
Message-ID: <alpine.DEB.2.02.1207261813080.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jul 2012, David Vrabel wrote:
> On 26/07/12 16:33, Stefano Stabellini wrote:
> > 
> > + * The hvc ISS is required to be 0xEA1, that is the Xen specific ARM
> > + * hypercall tag.
> 
> Is this number, 0xea1, assigned to Xen by some external body?

I am not aware of any "external body" that could assign us such a number
but it is specified in the Xen hypercall calling convention, documented
here:

http://xenbits.xensource.com/hg/xen-unstable.hg/file/663eb766cdde/xen/include/public/arch-arm.h
