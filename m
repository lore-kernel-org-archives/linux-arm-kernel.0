From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Fri, 27 Jul 2012 10:48:15 +0100
Subject: [PATCH 18/24] xen/arm: compile blkfront and blkback
In-Reply-To: <1343316846-25860-18-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-18-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1343382495.6812.127.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-26 at 16:34 +0100, Stefano Stabellini wrote:
> 
> +#define XEN_IO_PROTO_ABI_ARM        "arm-abi" 

I wonder if we ought to call this arm-aarch32-abi or something?

I wonder if we can also take the opportunity to fix the ABI cockup for
disks on ARM and make the structs the same for both 32 and 64 bit?

Ian.
