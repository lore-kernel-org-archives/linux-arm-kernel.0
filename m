From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 10 Aug 2015 12:32:40 +0100
Subject: [Xen-devel] [PATCH v3 09/20] xen/biomerge: Don't allow biovec
 to be merge when Linux is not using 4KB page
In-Reply-To: <alpine.DEB.2.02.1508101224220.11337@kaball.uk.xensource.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-10-git-send-email-julien.grall@citrix.com>
 <alpine.DEB.2.02.1508101149070.11337@kaball.uk.xensource.com>
 <55C889E4.8050307@citrix.com>
 <alpine.DEB.2.02.1508101224220.11337@kaball.uk.xensource.com>
Message-ID: <55C88BD8.7040807@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/15 12:25, Stefano Stabellini wrote:
> yes and page/pages:
> 
> xen/biomerge: Don't allow biovec's to be merged when Linux is not using 4KB pages

Why the ' in biovec's ? Shouldn't we says biovecs directly?

Regards,

-- 
Julien Grall
