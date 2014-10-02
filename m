From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 2 Oct 2014 11:36:07 +0100
Subject: [Xen-devel] [PATCH 1/2] xen/arm: remove handling of
 XENFEAT_grant_map_identity
In-Reply-To: <1412244417-12251-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1410021102480.17038@kaball.uk.xensource.com>
 <1412244417-12251-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <542D2A97.3040901@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/10/14 11:06, Stefano Stabellini wrote:
> Keep the definition of the flag.

If this is going away in Xen, you can get rid of the flag as well.

I think you should explain why it's being removed as well.

Should this be tagged for stable as well?

David
