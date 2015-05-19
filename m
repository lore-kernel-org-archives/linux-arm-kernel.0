From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 19 May 2015 14:50:54 +0100
Subject: [Xen-devel] [RFC 01/23] xen: Include xen/page.h rather than
 asm/xen/page.h
In-Reply-To: <1431622863-28575-2-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
 <1431622863-28575-2-git-send-email-julien.grall@citrix.com>
Message-ID: <555B3FBE.8030408@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/15 18:00, Julien Grall wrote:
> Using xen/page.h will be necessary later for using common xen page
> helpers.
> 
> As xen/page.h already include asm/xen/page.h, always use the later.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
