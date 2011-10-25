From: tj@kernel.org (Tejun Heo)
Date: Tue, 25 Oct 2011 08:35:38 -0700
Subject: [PATCH] lib: devres: add convenience function to remap a resource
In-Reply-To: <1319548607-28427-1-git-send-email-w.sang@pengutronix.de>
References: <1319548607-28427-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20111025153538.GA13012@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2011 at 03:16:47PM +0200, Wolfram Sang wrote:
> Almost every platform_driver does the three steps get_resource,
> request_mem_region, ioremap. This does not only lead to a lot of code
> duplication, but also a huge number of similar error strings and
> inconsistent error codes on failure. So, introduce a helper function
> which simplifies remapping a resource and make it hard to do something
> wrong and add documentation for it.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Greg KH <gregkh@suse.de>

 Acked-by: Tejun Heo <tj@kernel.org>

Greg, can you please take this one?

Thank you.

-- 
tejun
