From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 14 Nov 2016 15:42:07 +0100
Subject: [PATCH] staging: vc04_services: Remove explicit NULL pointer
In-Reply-To: <1478866605-1561-1-git-send-email-maninder.s2@samsung.com>
References: <1478866605-1561-1-git-send-email-maninder.s2@samsung.com>
Message-ID: <20161114144207.GA24686@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 05:46:45PM +0530, Maninder Singh wrote:
> Replace direct comparisons to NULL i.e.
> 'x == NULL' with '!x'
> 'x != NULL' with 'x'
> 
> Signed-off-by: Maninder Singh <maninder.s2@samsung.com>

A patch that was sent right before yours causes this patch to now have
conflicts.  Can you refresh it against my staging-testing branch and
resend?

thanks,

greg k-h
