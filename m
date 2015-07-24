From: ian.campbell@citrix.com (Ian Campbell)
Date: Fri, 24 Jul 2015 11:43:40 +0100
Subject: [Xen-devel] [PATCH v2 01/20] xen: Add Xen specific page definition
In-Reply-To: <55B214C5.3020501@citrix.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-2-git-send-email-julien.grall@citrix.com>
 <55B20540.3020000@citrix.com> <55B207C6.4020300@citrix.com>
 <55B209D9.1080602@citrix.com> <55B20ABE.7000609@citrix.com>
 <55B214C5.3020501@citrix.com>
Message-ID: <1437734620.24746.62.camel@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-07-24 at 11:34 +0100, David Vrabel wrote:
> it would be better to think that:
> 
> PFNs index guest-sized pages (which may be 64 KiB).
> 
> GFNs index Xen-sized pages (which is always 4 KiB).

This concept could be usefully added to the comment in
xen/include/xen/mm.h IMHO.


> 
> David
