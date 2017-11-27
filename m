From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 27 Nov 2017 10:08:17 +0100
Subject: [PATCH] staging: fsl-mc: fix uninitialized variable use
In-Reply-To: <20171127090134.19125-1-laurentiu.tudor@nxp.com>
References: <20171127090134.19125-1-laurentiu.tudor@nxp.com>
Message-ID: <20171127090817.GA14195@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 11:01:34AM +0200, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Fix this warning triggering on a powerpc build:
> warning: 'error' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---

You forgot a reported-by line :(

And I beat you by about 30 minutes to this patch, sorry about that.

Next time always test-build your patches...

thanks,

greg k-h
