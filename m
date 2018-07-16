From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 16 Jul 2018 10:34:41 +0200
Subject: [PATCH 2/4] staging: mt7621-pci: Fix coding style issues
 reported by checkpatch
In-Reply-To: <1531489266-20410-2-git-send-email-oliver.huebers@web.de>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
 <1531489266-20410-2-git-send-email-oliver.huebers@web.de>
Message-ID: <20180716083441.GA7903@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 03:41:04PM +0200, Oliver H?bers wrote:
> From: Vanessa Borgmann <nessa.x@web.de>
> 
> Fix errors: space errors, braces
> Fix warnings: comment warnings
> 
> Signed-off-by: Oliver H?bers <oliver.huebers@web.de>
> Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
> ---
>  drivers/staging/mt7621-pci/pci-mt7621.c | 230 ++++++++++++++++----------------
>  1 file changed, 112 insertions(+), 118 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
