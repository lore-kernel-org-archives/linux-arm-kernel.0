From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 25 May 2017 18:58:44 +0200
Subject: [PATCH 1/5][v2] staging: fsl-mc: fix several checkpath.pl warnings
In-Reply-To: <20170522120935.4119-2-laurentiu.tudor@nxp.com>
References: <20170522120935.4119-1-laurentiu.tudor@nxp.com>
 <20170522120935.4119-2-laurentiu.tudor@nxp.com>
Message-ID: <20170525165844.GA8812@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 03:09:31PM +0300, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Your subject line is very odd, please use the 'v2' marking properly...

> 
> Remove several unneeded #includes, forward
> declarations and fix several issues reported
> by checkpatch.pl --strict, such as:
>  - kfree(NULL) is safe and check is not required
>  - macro argument reuse may cause possible side effects
>  - enclose macro params in parens to avoid precedence issues
>  - coding style

These, as always, need to be broken up into one-patch-per-type-of-thing,
you have been in the staging tree long enough to know this :(

Please do this first, then we can consider the rest of the series...

thanks,

greg k-h
