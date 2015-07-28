From: david.vrabel@citrix.com (David Vrabel)
Date: Tue, 28 Jul 2015 18:19:09 +0100
Subject: [Xen-devel] [PATCH 8/8] xen/privcmd: Further s/MFN/GFN/ clean-up
In-Reply-To: <1438095769-2560-9-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-9-git-send-email-julien.grall@citrix.com>
Message-ID: <55B7B98D.3050008@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/15 16:02, Julien Grall wrote:
> The privcmd code is mixing the usage of GFN and MFN within the same
> functions which make the code difficult to understand when you only work
> with auto-translated guests.
> 
> The privcmd driver is only dealing with GFN so replace all the mention
> of MFN into GFN.
> 
> The ioctl structure used to map foreign change has been left unchanged
> given that the userspace is using it. Nonetheless, add a comment to
> explain the expected value within the "mfn" field.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
