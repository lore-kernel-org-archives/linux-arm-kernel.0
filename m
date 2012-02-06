From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 6 Feb 2012 15:20:28 -0800
Subject: [PATCH 1/2] genalloc: add support of named pool
In-Reply-To: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328466576-29384-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120206152028.310656a3.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun,  5 Feb 2012 19:29:35 +0100
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:

> so we can get the pool in the driver by name instead of passing it via
> parameter
> 
> this will be use on AT91 to get access from different drivers to the sram or
> gpbr as example
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Hi,
> 
> 	if you don't mind I'll apply this via at91 tree as it's needed to
> 	finish a cleanup on at91 to allow multiple soc in the same kernel

Please do not do this.

The patch is still as buggy as it was when I reviewed it in December. 
You didn't reply to my review email and you didn't reply to Steven
Rothwell's review email and you fixed almost none of our review
comments.
