From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 18 Jun 2013 19:48:39 -0700
Subject: [PATCH V2] USB: initialize or shutdown PHY when add or remove
 host controller
In-Reply-To: <1371609080-30595-1-git-send-email-chao.xie@marvell.com>
References: <1371609080-30595-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20130619024839.GA1987@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 10:31:20PM -0400, Chao Xie wrote:
> Some controller need software to initialize PHY before add
> host controller, and shut down PHY after remove host controller.
> Add the generic code for these controllers so they do not need
> do it in its own host controller driver.

Why?  What breaks if we add this patch, and what gets fixed?  I'm
guessing you can then remove code?

What out-of-tree code now works properly?  Or gets broken?

we need more info here please...

thanks,

greg k-h
