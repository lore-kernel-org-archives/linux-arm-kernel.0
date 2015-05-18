From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 18 May 2015 13:39:24 +0100
Subject: [Xen-devel] [PATCH] xen/arm: Define xen_arch_suspend()
In-Reply-To: <1431017723-27194-1-git-send-email-boris.ostrovsky@oracle.com>
References: <1431017723-27194-1-git-send-email-boris.ostrovsky@oracle.com>
Message-ID: <5559DD7C.1000508@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/15 17:55, Boris Ostrovsky wrote:
> Commit 2b953a5e994c ("xen: Suspend ticks on all CPUs during suspend")
> introduced xen_arch_suspend() routine but did so only for x86, breaking
> ARM builds.
> 
> We need to add it to ARM as well.

Applied to for-linus-4.1b, thanks.

Sorry for the delay, I assumed that Stefano would have picked this up.

David
